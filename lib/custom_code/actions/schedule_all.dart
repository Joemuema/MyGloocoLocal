// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future scheduleAll(List<DocumentReference> reminderDocs) async {
  for (DocumentReference reminderDoc in reminderDocs) {
    try {
      DocumentSnapshot reminderSnapshot = await reminderDoc.get();

      String frequency = reminderSnapshot['Frequency'];
      String date = reminderSnapshot['Date'];
      String time = reminderSnapshot['Time'];
      String reminderName = reminderSnapshot['Name'];

      DateTime startDate = reminderSnapshot['FIrstDateTime'].toDate();
      DateTime currentDate = startDate;
      DateTime endDate = reminderSnapshot['LastDateTime'].toDate();

      if (frequency == 'Once') {
        DateTime specificDate = stringToDate(date);
        startDate = specificDate;
        currentDate = startDate;
        endDate =
            DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
      } else {
        endDate = DateTime(endDate.year, endDate.month, endDate.day + 1);
      }

      DocumentSnapshot medSnapshot = await reminderSnapshot['MedicineID'].get();
      if (medSnapshot.exists) {
        String medName = medSnapshot['Name'];
        String form = medSnapshot['Form'];
        num dose = medSnapshot['SingleDose'];
        String finaldose;
        String unit = 'units';

        if (form == 'Pill') {
          unit = dose > 1 ? 'pills' : 'pill';
        } else if (form == 'Tablet') {
          unit = dose > 1 ? 'tablets' : 'tablet';
        } else if (form == 'Emulsion') {
          unit = dose > 1 ? 'tablespoons' : 'tablespoon';
        } else if (form == 'Injection') {
          unit = dose == 1 ? 'unit' : 'units';
        }

        if (dose % 1 == 0) {
          finaldose = dose.toInt().toString();
        } else {
          finaldose = dose.toString();
        }

        String title = '$reminderName reminder';
        String content =
            'Take $finaldose $unit of $medName. (Dismissing this reminder will mark it as missed)';

        scheduleAlarmNotification(
            title, content, time, frequency, startDate, endDate, reminderDoc);
      } else {
        print('Medicine document does not exist.');
      }
    } catch (e) {
      print('Failed to schedule reminders under ${reminderDoc.id}: $e');
    }
  }
}
