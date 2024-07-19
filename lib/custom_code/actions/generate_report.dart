// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
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

class MealLog {
  final DateTime date;
  final String meal;
  final String description;

  MealLog({required this.date, required this.meal, required this.description});

  factory MealLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MealLog(
      date: (data['date'] as Timestamp).toDate(),
      meal: data['meal'] as String,
      description: data['description'] as String,
    );
  }
}

class MedicationReminder {
  final String id;
  final DateTime date;
  final String type;
  final String medication;
  final String dosage;

  MedicationReminder({
    required this.id,
    required this.date,
    required this.type,
    required this.medication,
    required this.dosage,
  });

  factory MedicationReminder.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MedicationReminder(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] as String,
      medication: data['medication'] as String,
      dosage: data['dosage'] as String,
    );
  }
}

class BloodSugarReading {
  final DateTime date;
  final String time;
  final double reading;

  BloodSugarReading(
      {required this.date, required this.time, required this.reading});

  factory BloodSugarReading.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BloodSugarReading(
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] as String,
      reading: data['reading'].toDouble(),
    );
  }
}

class PhysicalActivity {
  final DateTime date;
  final String activity;
  final String duration;

  PhysicalActivity(
      {required this.date, required this.activity, required this.duration});

  factory PhysicalActivity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PhysicalActivity(
      date: (data['date'] as Timestamp).toDate(),
      activity: data['activity'] as String,
      duration: data['duration'] as String,
    );
  }
}

Future<List<MealLog>> fetchMealLogs(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('MealLogs')
      .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
      .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
      .get();

  return querySnapshot.docs.map((doc) => MealLog.fromFirestore(doc)).toList();
}

Future<List<MedicationReminder>> fetchMedicationReminders(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Medicine')
      .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
      .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
      .get();

  return querySnapshot.docs
      .map((doc) => MedicationReminder.fromFirestore(doc))
      .toList();
}

Future<List<BloodSugarReading>> fetchBloodSugarReadings(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('BloodSugarReadings')
      .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
      .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
      .get();

  return querySnapshot.docs
      .map((doc) => BloodSugarReading.fromFirestore(doc))
      .toList();
}

Future<double> calculateAverageBloodSugar(
    DateTime startDate, DateTime endDate) async {
  final readings = await fetchBloodSugarReadings(startDate, endDate);
  if (readings.isEmpty) return 0.0;
  final total = readings.map((r) => r.reading).reduce((a, b) => a + b);
  return total / readings.length;
}

Future<List<PhysicalActivity>> fetchPhysicalActivities(
    DateTime startDate, DateTime endDate) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('PhysicalActivities')
      .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
      .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
      .get();

  return querySnapshot.docs
      .map((doc) => PhysicalActivity.fromFirestore(doc))
      .toList();
}

Future<void> generateReport(
    DateTime selectedStartDate, List<Rcontent> selectedContents) async {
  final pdf = pw.Document();
  final selectedEndDate = DateTime.now();

  if (selectedContents.contains(Rcontent.Dietlogs)) {
    final mealLogs = await fetchMealLogs(selectedStartDate, selectedEndDate);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Diet Information', style: pw.TextStyle(fontSize: 18)),
            pw.Table.fromTextArray(context: context, data: [
              ['Date', 'Meal', 'Description'],
              ...mealLogs.map((log) => [
                    DateFormat('yyyy-MM-dd').format(log.date),
                    log.meal,
                    log.description
                  ])
            ]),
          ],
        ),
      ),
    );
  }

  if (selectedContents.contains(Rcontent.MedicineLogs)) {
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
                    DateFormat('yyyy-MM-dd').format(reminder.date),
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

  if (selectedContents.contains(Rcontent.BloodSugarLogs)) {
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
                    DateFormat('yyyy-MM-dd').format(reading.date),
                    reading.time,
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

  if (selectedContents.contains(Rcontent.PhysicalActivityLogs)) {
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
                    DateFormat('yyyy-MM-dd').format(activity.date),
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
      "${output.path}/report_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf");
  await file.writeAsBytes(await pdf.save());

  await Share.shareXFiles([XFile(file.path)],
      text: 'Here is your patient report.');
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
