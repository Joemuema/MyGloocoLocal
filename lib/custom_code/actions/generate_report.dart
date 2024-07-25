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

const String DIET_LOGS = 'DietLogs';
const String MEDICATION_LOGS = 'MedicationLogs';
const String BLOOD_SUGAR_LOGS = 'BloodSugarLogs';
const String PHYSICAL_ACTIVITY_LOGS = 'PhysicalActivityLogs';

class MealLog {
  final DateTime date;
  final String meal;
  final String description;

  MealLog({required this.date, required this.meal, required this.description});

  factory MealLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MealLog(
      date: (data['date'] as Timestamp).toDate(),
      meal: data['meal'] ?? '',
      description: data['description'] ?? '',
    );
  }
}

// Define your MedicationReminder data model
class MedicationReminder {
  final DateTime date;
  final String type;
  final String medication;
  final String dosage;

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

// Define your BloodSugarReading data model
class BloodSugarReading {
  final DateTime date;
  final String time;
  final double reading;

  BloodSugarReading({
    required this.date,
    required this.time,
    required this.reading,
  });

  factory BloodSugarReading.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BloodSugarReading(
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] ?? '',
      reading: (data['reading'] ?? 0).toDouble(),
    );
  }
}

// Define your PhysicalActivity data model
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
      date: (data['date'] as Timestamp).toDate(),
      activity: data['activity'] ?? '',
      duration: data['duration'] ?? '',
    );
  }
}

Future<void> generateReport(
    DateTime selectedStartDate, List<String> selectedContents) async {
  final pdf = pw.Document();
  final selectedEndDate = DateTime.now();

  if (selectedContents.contains(DIET_LOGS)) {
    final mealLogs = await fetchMealLogs(selectedStartDate, selectedEndDate);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Diet Information', style: pw.TextStyle(fontSize: 18)),
            pw.Table.fromTextArray(context: context, data: [
              ['Date', 'Meal', 'Description'],
              ...mealLogs.map((log) => [
                    log?.date != null
                        ? DateFormat('yyyy-MM-dd').format(log!.date)
                        : 'N/A',
                    log?.meal ?? 'N/A',
                    log?.description ?? 'N/A'
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
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Medication Reminders', style: pw.TextStyle(fontSize: 18)),
            pw.Table.fromTextArray(context: context, data: [
              ['Date', 'Type', 'Medication', 'Dosage'],
              ...medicationReminders.map((reminder) => [
                    reminder?.date != null
                        ? DateFormat('yyyy-MM-dd').format(reminder!.date)
                        : 'N/A',
                    reminder?.type ?? 'N/A',
                    reminder?.medication ?? 'N/A',
                    reminder?.dosage ?? 'N/A',
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
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Blood Sugar Readings', style: pw.TextStyle(fontSize: 18)),
            pw.Table.fromTextArray(context: context, data: [
              ['Date', 'Time', 'Reading (mg/dL)'],
              ...bloodSugarReadings.map((reading) => [
                    reading?.date != null
                        ? DateFormat('yyyy-MM-dd').format(reading!.date)
                        : 'N/A',
                    reading?.time ?? 'N/A',
                    reading?.reading?.toString() ?? 'N/A'
                  ])
            ]),
            pw.SizedBox(height: 10),
            pw.Text(
                'Average Blood Sugar: ${averageBloodSugar?.toStringAsFixed(2) ?? 'N/A'} mg/dL',
                style: pw.TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  if (selectedContents.contains(PHYSICAL_ACTIVITY_LOGS)) {
    final physicalActivities =
        await fetchPhysicalActivities(selectedStartDate, selectedEndDate);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Physical Activity', style: pw.TextStyle(fontSize: 18)),
            pw.Table.fromTextArray(context: context, data: [
              ['Date', 'Activity', 'Duration'],
              ...physicalActivities.map((activity) => [
                    activity?.date != null
                        ? DateFormat('yyyy-MM-dd').format(activity!.date)
                        : 'N/A',
                    activity?.activity ?? 'N/A',
                    activity?.duration ?? 'N/A'
                  ])
            ]),
          ],
        ),
      ),
    );
  }

  final output = await getTemporaryDirectory();
  final file = File(
      "${output.path}/report_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf");
  await file.writeAsBytes(await pdf.save());

  await Share.shareXFiles([XFile(file.path)],
      text: 'Here is your patient report.');
}

Future<List<MealLog>> fetchMealLogs(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Meals')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();

  return querySnapshot.docs.map((doc) => MealLog.fromFirestore(doc)).toList();
}

Future<List<MedicationReminder>> fetchMedicationReminders(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Medicine')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();

  return querySnapshot.docs
      .map((doc) => MedicationReminder.fromFirestore(doc))
      .toList();
}

Future<List<BloodSugarReading>> fetchBloodSugarReadings(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('BloodSugar')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();

  return querySnapshot.docs
      .map((doc) => BloodSugarReading.fromFirestore(doc))
      .toList();
}

Future<double> calculateAverageBloodSugar(
    DateTime startDate, DateTime endDate) async {
  final readings = await fetchBloodSugarReadings(startDate, endDate);
  if (readings.isEmpty) return 0.0;

  final total =
      readings.fold(0.0, (sum, reading) => sum + (reading?.reading ?? 0.0));
  return total / readings.length;
}

Future<List<PhysicalActivity>> fetchPhysicalActivities(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('PhysicalActivities')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();

  return querySnapshot.docs
      .map((doc) => PhysicalActivity.fromFirestore(doc))
      .toList();
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
