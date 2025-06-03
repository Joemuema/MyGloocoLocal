// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermissions() async {
  bool notificationsAllowed = await initializeNotifications();

  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }

  bool alarmsAllowed = false;
  PermissionStatus status = await Permission.scheduleExactAlarm.status;
  if (status.isGranted) {
    alarmsAllowed = true;
  }

  return notificationsAllowed && alarmsAllowed;
}
