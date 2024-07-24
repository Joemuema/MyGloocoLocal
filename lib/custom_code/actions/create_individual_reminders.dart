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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future createIndividualReminders(List<DocumentReference> remindersDocs) async {
  for (DocumentReference reminderDoc in remindersDocs) {
    try {
      DocumentSnapshot reminderSnapshot = await reminderDoc.get();
      if (!reminderSnapshot.exists) continue;

      String frequency = reminderSnapshot['frequency'];
      DateTime lastUpdated = reminderSnapshot['lastUpdated'].toDate();
      String day = reminderSnapshot['Day'];
      int dateNumber = reminderSnapshot['DateNumber'];

      DateTime now = DateTime.now();
      DateTime startDate = lastUpdated;

      while (startDate.isBefore(now) || startDate.isAtSameMomentAs(now)) {
        bool addReminder = false;

        if (frequency == 'daily') {
          addReminder = true;
        } else if (frequency == 'weekly' &&
            day == DateFormat('EEEE').format(startDate)) {
          addReminder = true;
        } else if (frequency == 'monthly' && dateNumber == startDate.day) {
          addReminder = true;
        }

        if (addReminder) {
          DocumentReference newIndividualReminder =
              reminderDoc.collection('individualReminders').doc();
          await newIndividualReminder.set({
            'reminderID': reminderDoc,
            'IsActive': true,
            'Status': 'Missed',
          });
        }

        startDate = startDate.add(Duration(days: 1));
      }

      // Update lastUpdated field in Reminders document
      await reminderDoc.update({'lastUpdated': now});
      print(
          'individualReminders created successfully under ${reminderDoc.id} and lastUpdated field updated.');
    } catch (e) {
      print('Failed to create individualReminders under ${reminderDoc.id}: $e');
    }
  }
}
