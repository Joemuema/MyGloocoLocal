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

import 'package:shared_preferences/shared_preferences.dart';

Future<int> getNextNotificationId() async {
  final prefs = await SharedPreferences.getInstance();
  int currentId = prefs.getInt('notification_id') ?? 0;
  int nextId = currentId + 1;
  await prefs.setInt('notification_id', nextId);
  return nextId;
}
