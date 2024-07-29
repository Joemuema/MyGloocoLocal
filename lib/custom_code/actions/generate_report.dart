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
const String BLOOD_SUGAR_LOGS = 'BloodSugarLogs';

class MealLog {
  final DateTime date;
  final List meal;
  final String type;

  MealLog({required this.date, required this.meal, required this.type});
  factory MealLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MealLog(
      date: stringToDate(data['date']),
      meal: data['meal'] ?? [],
      type: data['type'] ?? '',
    );
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
      date: stringToDate(data['date']),
      period: data['period'] ?? '',
      cgmReading: (data['CGMreading'] ?? 0).toDouble(),
    );
  }
}

Future<String> generateReport(
    DateTime selectedStartDate, List<String> selectedContents) async {
  final pdf = pw.Document();
  final selectedEndDate = DateTime.now();

  try {
    if (selectedContents.contains(DIET_LOGS)) {
      List<MealLog> mealLogs = []; // Declare mealLogs here
      try {
        final querySnapshot =
            await FirebaseFirestore.instance.collection('Meals').get();

        if (querySnapshot.docs.isEmpty) {
          print("No meal logs found for the given date range.");
        } else {
          mealLogs = querySnapshot.docs // Assign mealLogs here
              .where((doc) {
                final date = DateTime.parse(doc.data()['date']);
                return date.isAfter(selectedStartDate) &&
                    date.isBefore(selectedEndDate);
              })
              .map((doc) => MealLog.fromFirestore(doc))
              .toList();
        }
      } catch (e) {
        print("Error fetching meal logs: $e");
        throw Exception("Failed to fetch meal logs: $e");
      }
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
                          ? DateFormat('yyyy-MM-dd').format(log.date)
                          : 'N/A',
                      log.meal.join(','),
                      log.type
                    ])
              ]),
            ],
          ),
        ),
      );
    }

    if (selectedContents.contains(BLOOD_SUGAR_LOGS)) {
      List<BloodSugarReading> bloodSugarReadings =
          []; // Declare bloodSugarReadings here
      try {
        final querySnapshot =
            await FirebaseFirestore.instance.collection('BGreadings').get();

        if (querySnapshot.docs.isEmpty) {
          print("No blood sugar readings found for the given date range.");
        } else {
          bloodSugarReadings =
              querySnapshot.docs // Assign bloodSugarReadings here
                  .where((doc) {
                    final date = DateTime.parse(doc.data()['date']);
                    return date.isAfter(selectedStartDate) &&
                        date.isBefore(selectedEndDate);
                  })
                  .map((doc) => BloodSugarReading.fromFirestore(doc))
                  .toList();
        }
      } catch (e) {
        print("Error fetching blood sugar readings: $e");
        throw Exception("Failed to fetch blood sugar readings: $e");
      }

      print(
          "Fetched ${bloodSugarReadings.length} blood sugar readings: $bloodSugarReadings");

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Blood Sugar Readings',
                  style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(context: context, data: [
                ['Date', 'Period', 'CGM Reading (mg/dL)'],
                ...bloodSugarReadings.map((reading) => [
                      reading.date != null
                          ? DateFormat('yyyy-MM-dd').format(reading.date)
                          : 'N/A',
                      reading.period,
                      reading.cgmReading.toString()
                    ])
              ]),
              pw.SizedBox(height: 10),
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
