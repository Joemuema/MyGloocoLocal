// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

Future scheduleNotification(
  String? title,
  String? content,
  String? time,
) async {
  print('Provided time: $time');

  await requestNotificationPermissions();
  DateTime parsedTime = DateFormat.jm().parse(time!);

  tzdata.initializeTimeZones();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var androidSettings = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher', //Replace with icon name, no extension
  );

  var notificationDetails =
      NotificationDetails(android: androidSettings, iOS: null);

  final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  final location = tz.getLocation(timeZoneName);

  var scheduledTime = tz.TZDateTime.from(parsedTime, location);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title!,
    content!,
    scheduledTime,
    notificationDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    payload: 'Custom_Sound',
  );
}
