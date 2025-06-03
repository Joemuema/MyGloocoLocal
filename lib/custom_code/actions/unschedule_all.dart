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
  /*  for (DocumentReference reminderDoc in reminderDocs) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Reminders')
        .doc(reminderDoc.id)
        .collection('individualReminders')
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      DocumentReference docRef = doc.reference;
      int notificationID = docRef['NotificationID'];
      cancelNotification(notificationID);
    }
  } */
  for (int i = 69; i <= 132; i++) {
    cancelNotification(i);
  }
}
