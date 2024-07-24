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

import 'package:awesome_notifications/awesome_notifications.dart';

Future<bool> initializeNotifications() async {
  AwesomeNotifications().initialize(
    'resource://drawable/res_logo',
    [
      NotificationChannel(
        channelKey: 'alarm_channel',
        channelName: 'Alarm Notifications',
        channelDescription: 'Notification channel for alarms',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
        channelShowBadge: true,
        locked: true,
        criticalAlerts: true,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
      )
    ],
  );

  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  isAllowed = await AwesomeNotifications().isNotificationAllowed();
  return isAllowed;
}
