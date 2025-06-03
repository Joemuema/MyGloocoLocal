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

Future deleteIndividualReminders(DocumentReference remindersDocRef) async {
  try {
    final individualRemindersSnapshot =
        await remindersDocRef.collection('IndividualReminders').get();

    if (individualRemindersSnapshot.docs.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();

      for (var doc in individualRemindersSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    }

    await remindersDocRef.delete();

    print(
        'Successfully deleted Reminders document and all associated IndividualReminders documents.');
  } catch (e) {
    print('Error occurred while deleting documents: $e');
  }
}
