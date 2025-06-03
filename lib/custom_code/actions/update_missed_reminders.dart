// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future updateMissedReminders(List<IndividualRemindersRecord> reminders) async {
  try {
    final batch = FirebaseFirestore.instance.batch();

    for (var reminder in reminders) {
      batch.update(reminder.reference, {'Status': 'Missed'});
    }

    await batch.commit();

    print('Updated ${reminders.length} documents to "Missed".');
  } catch (e) {
    print('Error occurred while updating reminders: $e');
  }
}
