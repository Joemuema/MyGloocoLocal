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
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

Future scheduleAlarmNotification(
  String? title,
  String? content,
  String? time,
) async {
  print('Provided time: $time');

  // Initialize time zones
  tzdata.initializeTimeZones();

  AwesomeNotifications().initialize(
    'resource://drawable/logo', // Replace with your app icon resource
    [
      NotificationChannel(
        channelKey: 'alarm_channel',
        channelName: 'Alarm Notifications',
        channelDescription: 'Notification channel for alarms',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Color(0xFF9D50DD),
        importance: NotificationImportance.High,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
      )
    ],
  );

  // Request notification permissions
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    // Request permissions if not already granted
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Parse the provided time string
  DateTime parsedTime = DateFormat.jm().parse(time!);
  DateTime now = DateTime.now();

  if (parsedTime == null) {
    print('Failed to parse time: $time');
    return;
  }

  parsedTime = DateTime(
      now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

  print('Parsed time: $parsedTime');

  // Get the device's timezone
  String timeZoneName = await FlutterTimezone.getLocalTimezone();
  print('Device timezone: $timeZoneName');

  // Use the correct timezone location
  final tzLocation = tz.getLocation(timeZoneName);

  // Create a TZDateTime object for the scheduled time
  var scheduledTime = tz.TZDateTime.from(parsedTime, tzLocation);

  if (scheduledTime.isBefore(tz.TZDateTime.now(tzLocation))) {
    print('Scheduled time is in the past: $scheduledTime');
    return;
  }

  // Schedule the notification
  try {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'alarm_channel',
        title: title,
        body: content,
        notificationLayout: NotificationLayout.Default,
        locked: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        icon: 'resource://drawable/logo',
      ),
      schedule: NotificationCalendar(
        year: scheduledTime.year,
        month: scheduledTime.month,
        day: scheduledTime.day,
        hour: scheduledTime.hour,
        minute: scheduledTime.minute,
        second: 0,
        millisecond: 0,
        timeZone: timeZoneName,
        repeats: false,
      ),
    );

    print('Notification scheduled for $scheduledTime');
  } catch (e) {
    print('Failed to schedule notification: $e');
  }
}
