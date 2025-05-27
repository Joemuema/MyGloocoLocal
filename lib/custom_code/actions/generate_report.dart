// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// set all past reminders to missed after a period of time (lastupdated var)

import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Constants for log types
const String DIET_LOGS = 'DietLogs';
const String PHYSICAL_ACTIVITY = 'PhysicalActivityLogs';
const String BLOOD_SUGAR_LOGS = 'BloodSugarLogs';
const String MEDICINE_LOG = 'MedicationLogs';

class MealLog {
  final DateTime date;
  final List meal;
  final String type;
  // final DocumentReference userid;

  MealLog({required this.date, required this.meal, required this.type});

  factory MealLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MealLog(
        date: stringToDate(data['date']),
        meal: data['meals'] ?? [],
        type: data['type'] ?? '');
  }
}

class PhysicalActivity {
  final DateTime date;
  final String activity;
  final String intensity;

  PhysicalActivity(
      {required this.date, required this.activity, required this.intensity});

  factory PhysicalActivity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PhysicalActivity(
        date: (data['date']).toDate(),
        activity: data['activity'] ?? '',
        intensity: data['intensity'] ?? '');
  }
}

class BloodSugarReading {
  final DateTime date;
  final String period;
  final double cgmReading;

  BloodSugarReading({
    required this.date,
    required this.period,
    required this.cgmReading,
  });

  factory BloodSugarReading.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BloodSugarReading(
        date: stringToDate(data['Date']),
        period: data['Period'] ?? '',
        cgmReading: (data['CGMreading']).toDouble());
  }
}

class MedicineRecord {
  final DateTime date;
  final String time;
  final String status;
  final String name;
  final String dose;
  final String unit;

  MedicineRecord(
      {required this.date,
      required this.time,
      required this.name,
      required this.dose,
      required this.status,
      required this.unit});

  factory MedicineRecord.fromFirestore(DocumentSnapshot doc,
      String medicineName, String doseAmount, String medicineUnit) {
    final data = doc.data() as Map<String, dynamic>;

    return MedicineRecord(
        date: stringToDate(data['Date']),
        time: data['Time'],
        name: medicineName,
        dose: doseAmount,
        status: data['Status'],
        unit: medicineUnit);
  }
}

Future<String> generateReport(
  DateTime selectedStartDate,
  List<String> selectedContents,
  DocumentReference userID,
  DateTime selectedEndDate,
) async {
  final pdf = pw.Document();
  selectedEndDate = incrementDate(selectedEndDate);
  selectedStartDate = decrementDate(selectedStartDate);

  try {
    if (selectedContents.contains(DIET_LOGS)) {
      List<MealLog> mealLogs = [];
      try {
        final querySnapshot =
            await FirebaseFirestore.instance.collection('Meals').get();

        if (querySnapshot.docs.isEmpty) {
          print("No meal logs found for the given date range.");
        } else {
          mealLogs = querySnapshot.docs
              .where((doc) {
                final date = DateTime.parse(doc.data()['date']);
                DocumentReference user_id = doc.data()['UserID'];

                return user_id == userID &&
                    date.isAfter(selectedStartDate) &&
                    date.isBefore(selectedEndDate);
              })
              .map((doc) => MealLog.fromFirestore(doc))
              .toList();
        }
      } catch (e) {
        print("Error fetching meal logs: $e");
        throw Exception("Failed to fetch meal logs: $e");
      }

      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => [
            pw.Text('Diet Information', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: ['Date', 'Meal', 'Type'],
              data: mealLogs
                  .map((log) => [
                        getDate(log.date),
                        log.meal.map((meal) => meal).join('\n'),
                        log.type,
                      ])
                  .toList(),
            ),
          ],
        ),
      );
    }

    if (selectedContents.contains(PHYSICAL_ACTIVITY)) {
      List<PhysicalActivity> physicalactivities = [];
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('addpagecollection')
            .get();

        if (querySnapshot.docs.isEmpty) {
          print("No physical activity logs found for the given date range.");
        } else {
          physicalactivities = querySnapshot.docs
              .where((doc) {
                final date = (doc.data()['date']).toDate();
                DocumentReference user_id = doc.data()['UserID'];

                return user_id == userID &&
                    date.isAfter(selectedStartDate) &&
                    date.isBefore(selectedEndDate);
              })
              .map((doc) => PhysicalActivity.fromFirestore(doc))
              .toList();
        }
      } catch (e) {
        print("Error fetching physical activity logs: $e");
        throw Exception("Failed to fetch physical activity: $e");
      }

      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => [
            pw.Text('Physical Activity Information',
                style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: ['Date', 'Activity', 'Intensity'],
              data: physicalactivities
                  .map((log) => [
                        getDate(log.date),
                        log.activity,
                        log.intensity,
                      ])
                  .toList(),
            ),
          ],
        ),
      );
    }

    if (selectedContents.contains(BLOOD_SUGAR_LOGS)) {
      List<BloodSugarReading> bloodSugarReadings = [];
      try {
        final querySnapshot =
            await FirebaseFirestore.instance.collection('BGreadings').get();

        if (querySnapshot.docs.isEmpty) {
          print("No blood sugar readings found for the given date range.");
        } else {
          bloodSugarReadings = querySnapshot.docs
              .where((doc) {
                final date = DateTime.parse(doc.data()['Date']);
                DocumentReference user_id = doc.data()['UserID'];

                return user_id == userID &&
                    date.isAfter(selectedStartDate) &&
                    date.isBefore(selectedEndDate);
              })
              .map((doc) => BloodSugarReading.fromFirestore(doc))
              .toList();
        }
      } catch (e) {
        print("Error fetching blood sugar readings: $e");
        throw Exception("Failed to fetch blood sugar readings: $e");
      }

      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => [
            pw.Text('Blood Sugar Readings', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: ['Date', 'Period', 'CGM Reading (mg/dL)'],
              data: bloodSugarReadings
                  .map((reading) => [
                        getDate(reading.date),
                        reading.period,
                        reading.cgmReading.toString(),
                      ])
                  .toList(),
            ),
          ],
        ),
      );
    }

    if (selectedContents.contains(MEDICINE_LOG)) {
      List<MedicineRecord> medLogs = [];
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collectionGroup('IndividualReminders')
            .get();

        if (querySnapshot.docs.isEmpty) {
          print("No medicine logs found for the given date range.");
        } else {
          for (var doc in querySnapshot.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final date = stringToDate(data['Date']);
            String status = data['Status'];
            DocumentReference user_id = data['UserID'];

            if (user_id == userID &&
                date.isAfter(selectedStartDate) &&
                date.isBefore(selectedEndDate) &&
                (status == 'Taken' || status == 'Missed')) {
              DocumentSnapshot reminderSnapshot =
                  await data['ReminderID'].get();
              DocumentReference medicineRef = reminderSnapshot['MedicineID'];
              DocumentSnapshot medicineSnapshot = await medicineRef.get();

              String medicineName = medicineSnapshot['Name'];
              double dose = (medicineSnapshot['SingleDose']).toDouble();
              String dosage = dose % 1 == 0
                  ? dose.toInt().toString()
                  : dose.toStringAsFixed(2);
              String form = medicineSnapshot['Form'];
              String unit = 'units';

              if (form == 'Pill') {
                unit = dose > 1 ? 'pills' : 'pill';
              } else if (form == 'Tablet') {
                unit = dose > 1 ? 'tablets' : 'tablet';
              } else if (form == 'Emulsion') {
                double tbsp = dose / 15;
                unit = 'ml(${tbsp.toStringAsFixed(2)} ';
                unit += tbsp == 1 ? 'tablespoon' : 'tablespoons';
                unit += ')';
              } else if (form == 'Injection') {
                unit = dose == 1 ? 'unit' : 'units';
              }

              MedicineRecord medRecord =
                  MedicineRecord.fromFirestore(doc, medicineName, dosage, unit);
              medLogs.add(medRecord);
            }
          }
        }
      } catch (e) {
        print("Error fetching medicine logs: $e");
      }

      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => [
            pw.Text('Medicine Records', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: [
                'Date',
                'Time taken',
                'Medicine Name',
                'Dose',
                'Status'
              ],
              data: medLogs
                  .map((log) => [
                        getDate(log.date),
                        log.time,
                        log.name,
                        '${log.dose} ${log.unit}',
                        log.status,
                      ])
                  .toList(),
            ),
          ],
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File(
        "${output.path}/report_${DateFormat('ddMMyyyy_HHmmss').format(DateTime.now())}.pdf");
    await file.writeAsBytes(await pdf.save());
    print("PDF saved at ${file.path}");

    await Share.shareXFiles([XFile(file.path)],
        text: 'Here is your patient report.');

    OpenFilex.open(file.path);

    return file.path;
  } catch (e) {
    print("Error generating report: $e");
    rethrow;
  }
}
