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

Future unscheduleAll(List<DocumentReference> reminderDocs) async {
  for (DocumentReference reminderDoc in reminderDocs) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Reminders')
        .doc(reminderDoc.id)
        .collection('IndividualReminders')
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      int notificationID = doc.get('NotificationID');
      cancelNotification(notificationID);
    }
  }
}
