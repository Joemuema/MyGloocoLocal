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
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

Future scheduleNotification(
  String? title,
  String? content,
  String? time,
) async {
  try {
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

    var deviceTimeZone = tz.getLocation(
        'Etc/GMT${now.timeZoneOffset.inHours > 0 ? '+' : ''}${now.timeZoneOffset.inHours}');
    print('Using inferred timezone: ${deviceTimeZone.name}');

    var scheduledTime = tz.TZDateTime.from(parsedTime, deviceTimeZone);

    if (scheduledTime.isBefore(tz.TZDateTime.now(deviceTimeZone))) {
      print('Scheduled time is in the past: $scheduledTime');
      return;
    }

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
