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

Future setIndividualReminders(List<DocumentReference> reminderDocs) async {
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

      String day = reminderSnapshot['Day'];
      int dateNumber = reminderSnapshot['DateNumber'];

      while (currentDate.isBefore(endDate)) {
        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        if (currentDate.isBefore(today)) {
          currentDate = currentDate.add(Duration(days: 1));
          continue;
        }

        bool addReminder = false;

        if (frequency == 'Once' || frequency == 'Daily') {
          addReminder = true;
        } else if (frequency == 'Weekly') {
          if (day == DateFormat('EEEE').format(currentDate)) {
            addReminder = true;
          }
        } else if (frequency == 'Monthly') {
          if (dateNumber == currentDate.day) {
            addReminder = true;
          }
        }

        if (addReminder) {
          DocumentReference newIndividualReminder =
              reminderDoc.collection('IndividualReminders').doc();
          await newIndividualReminder.set({
            'UserID': reminderSnapshot['UserID'],
            'ReminderID': reminderDoc,
            'IsActive': true,
            'Date': getDate(currentDate),
            'Time': time,
            'Status': 'Unset',
          });
        }

        currentDate = currentDate.add(Duration(days: 1));
      }

      print(
          'individualReminders created successfully under ${reminderDoc.id}.');

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
          double tbsp = dose / 15;
          unit = 'ml(${tbsp.toStringAsFixed(2)} ';
          unit += tbsp == 1 ? 'tablespoon' : 'tablespoons';
          unit += ')';
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
      print('Failed to create individualReminders under ${reminderDoc.id}: $e');
    }
  }
}
