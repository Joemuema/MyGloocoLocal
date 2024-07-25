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

Future deleteDocuments(List<DocumentReference> documentReferences) async {
  for (DocumentReference docRef in documentReferences) {
    try {
      await docRef.delete();
    } catch (e) {
      print('Failed to delete document ${docRef.id}: $e');
    }
  }
}
