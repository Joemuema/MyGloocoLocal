// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<double> averageGlucoseToday(List<DocumentReference> documents) async {
  double total = 0.0;
  int count = 0;

  for (DocumentReference docRef in documents) {
    DocumentSnapshot doc = await docRef.get();

    total += doc['CGMreading'];
    count++;
  }

  if (count == 0) {
    return 0.0;
  }

  return total / count;
}
