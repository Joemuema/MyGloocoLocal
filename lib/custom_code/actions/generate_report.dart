// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Constants for log types
const String DIET_LOGS = 'DietLogs';
const String MEDICATION_LOGS = 'MedicationLogs';
const String BLOOD_SUGAR_LOGS = 'BloodSugarLogs';
const String PHYSICAL_ACTIVITY_LOGS = 'PhysicalActivityLogs';

class MealLog {
  final DateTime date;
  final List meal;
  final String type;

  MealLog({required this.date, required this.meal, required this.type});

  factory MealLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MealLog(
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      meal: data['meal'] ?? [],
      type: data['type'] ?? '',
    );
  }
}

class BloodSugarReading {
  final DateTime date;
  final String period;
  final double reading;

  BloodSugarReading({
    required this.date,
    required this.period,
    required this.reading,
  });

  factory BloodSugarReading.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BloodSugarReading(
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      period: data['period'] ?? '',
      reading: (data['reading'] ?? 0).toDouble(),
    );
  }
}

class MedicationReminder {
  final DateTime date;
  final String type;
  final String medication;
  final double dosage;

  MedicationReminder({
    required this.date,
    required this.type,
    required this.medication,
    required this.dosage,
  });

  factory MedicationReminder.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MedicationReminder(
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] ?? '',
      medication: data['medication'] ?? '',
      dosage: data['dosage'] ?? '',
    );
  }
}

class PhysicalActivity {
  final DateTime date;
  final String activity;
  final String duration;

  PhysicalActivity({
    required this.date,
    required this.activity,
    required this.duration,
  });

  factory PhysicalActivity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PhysicalActivity(
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      activity: data['activity'] ?? '',
      duration: data['duration'] ?? '',
    );
  }
}

Future<String> generateReport(
    DateTime selectedStartDate, List<String> selectedContents) async {
  final pdf = pw.Document();
  final selectedEndDate = DateTime.now();

  try {
    if (selectedContents.contains(DIET_LOGS)) {
      final mealLogs = await fetchMealLogs(selectedStartDate, selectedEndDate);
      print("Fetched ${mealLogs.length} meal logs: $mealLogs");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Diet Information', style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(context: context, data: [
                ['Date', 'Meal', 'Type'],
                ...mealLogs.map((log) => [
                      log.date != null
                          ? DateFormat('dd-MM-yyyy').format(log.date)
                          : 'N/A',
                      log.meal.toString(),
                      log.type
                    ])
              ]),
            ],
          ),
        ),
      );
    }

    if (selectedContents.contains(MEDICATION_LOGS)) {
      final medicationReminders =
          await fetchMedicationReminders(selectedStartDate, selectedEndDate);
      print(
          "Fetched ${medicationReminders.length} medication reminders: $medicationReminders");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Medication Reminders',
                  style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(context: context, data: [
                ['Date', 'Type', 'Medication', 'Dosage'],
                ...medicationReminders.map((reminder) => [
                      reminder.date != null
                          ? DateFormat('dd-MM-yyyy').format(reminder.date)
                          : 'N/A',
                      reminder.type,
                      reminder.medication,
                      reminder.dosage,
                    ]),
              ]),
            ],
          ),
        ),
      );
    }

    if (selectedContents.contains(BLOOD_SUGAR_LOGS)) {
      final bloodSugarReadings =
          await fetchBloodSugarReadings(selectedStartDate, selectedEndDate);
      final averageBloodSugar =
          await calculateAverageBloodSugar(selectedStartDate, selectedEndDate);
      print(
          "Fetched ${bloodSugarReadings.length} blood sugar readings: $bloodSugarReadings");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Blood Sugar Readings',
                  style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(context: context, data: [
                ['Date', 'Period', 'Reading (mg/dL)'],
                ...bloodSugarReadings.map((reading) => [
                      reading.date != null
                          ? DateFormat('dd-MM-yyyy').format(reading.date)
                          : 'N/A',
                      reading.period,
                      reading.reading.toString()
                    ])
              ]),
              pw.SizedBox(height: 10),
              pw.Text(
                  'Average Blood Sugar: ${averageBloodSugar.toStringAsFixed(2)} mg/dL',
                  style: pw.TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    if (selectedContents.contains(PHYSICAL_ACTIVITY_LOGS)) {
      final physicalActivities =
          await fetchPhysicalActivities(selectedStartDate, selectedEndDate);
      print(
          "Fetched ${physicalActivities.length} physical activities: $physicalActivities");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Physical Activity', style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(context: context, data: [
                ['Date', 'Activity', 'Duration'],
                ...physicalActivities.map((activity) => [
                      activity.date != null
                          ? DateFormat('dd-MM-yyyy').format(activity.date)
                          : 'N/A',
                      activity.activity,
                      activity.duration
                    ])
              ]),
            ],
          ),
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

Future<List<MealLog>> fetchMealLogs(
    DateTime startDate, DateTime endDate) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Meals')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs.map((doc) => MealLog.fromFirestore(doc)).toList();
  } catch (e) {
    print("Error fetching meal logs: $e");
    return [];
  }
}

Future<List<MedicationReminder>> fetchMedicationReminders(
    DateTime startDate, DateTime endDate) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Medicine')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs
        .map((doc) => MedicationReminder.fromFirestore(doc))
        .toList();
  } catch (e) {
    print("Error fetching medication reminders: $e");
    return [];
  }
}

Future<List<BloodSugarReading>> fetchBloodSugarReadings(
    DateTime startDate, DateTime endDate) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('bloodglucose')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs
        .map((doc) => BloodSugarReading.fromFirestore(doc))
        .toList();
  } catch (e) {
    print("Error fetching blood sugar readings: $e");
    return [];
  }
}

Future<double> calculateAverageBloodSugar(
    DateTime startDate, DateTime endDate) async {
  try {
    final readings = await fetchBloodSugarReadings(startDate, endDate);
    if (readings.isEmpty) return 0.0;

    final total = readings.fold(0.0, (sum, reading) => sum + reading.reading);
    return total / readings.length;
  } catch (e) {
    print("Error calculating average blood sugar: $e");
    return 0.0;
  }
}

Future<List<PhysicalActivity>> fetchPhysicalActivities(
    DateTime startDate, DateTime endDate) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('PhysicalActivities')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs
        .map((doc) => PhysicalActivity.fromFirestore(doc))
        .toList();
  } catch (e) {
    print("Error fetching physical activities: $e");
    return [];
  }
}
