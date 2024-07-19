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

import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

Future scheduleNotification(
  String? title,
  String? content,
  String? time,
) async {
  print('Provided time: $time');

  DateTime parsedTime = DateFormat.jm().parse(time!);
  DateTime now = DateTime.now();

  if (parsedTime == null) {
    print('Failed to parse time: $time');
    return;
  }

  parsedTime = DateTime(
      now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

  print('Parsed time: $parsedTime');

  tzdata.initializeTimeZones();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: null);

  /* await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    navigateToMedPage();
  });*/

  var androidSettings = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher', //Replace with icon name, no extension
  );

  var notificationDetails =
      NotificationDetails(android: androidSettings, iOS: null);

  // var deviceTimeZone = tz.local;
  // var local = tz.getLocation(tz.local.name);
  // print('Using timezone: ${local.name}');

  //var deviceTimeZone = tz.getLocation(
  //    'Etc/GMT${now.timeZoneOffset.inHours > 0 ? '+' : ''}${now.timeZoneOffset.inHours}');
  //print('Using inferred timezone: ${deviceTimeZone.name}');

  // Get the device's timezone
  String timeZoneName = await FlutterTimezone.getLocalTimezone();
  print('Device timezone: $timeZoneName');

  // Use the correct timezone location
  final tzLocation = tz.getLocation(timeZoneName);

  var scheduledTime = tz.TZDateTime.from(parsedTime, tzLocation);

  if (scheduledTime.isBefore(tz.TZDateTime.now(tzLocation))) {
    print('Scheduled time is in the past: $scheduledTime');
    return;
  }

  try {
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

    print('Notification scheduled for $scheduledTime');
  } catch (e) {
    print('Failed to schedule notification: $e');
  }
}
