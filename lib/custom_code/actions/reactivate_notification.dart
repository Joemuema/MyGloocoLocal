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
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

Future reactivateNotification(
  int notificationID,
  DocumentReference reminderID,
  String date,
  String time,
  String title,
  String content,
) async {
  tzdata.initializeTimeZones();

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

  DateTime dateTime = stringToDate(date);
  DateTime parsedTime = DateFormat('HH:mm').parse(time);

  String timeZoneName = await FlutterTimezone.getLocalTimezone();
  final tzLocation = tz.getLocation(timeZoneName);

  var tzScheduledTime = tz.TZDateTime.from(
      DateTime(dateTime.year, dateTime.month, dateTime.day, parsedTime.hour,
          parsedTime.minute),
      tzLocation);

  Map<String, String?> additionalInfo = {
    'Date': date,
    'Time': time,
    'ReminderID': reminderID.path,
  };

  try {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationID,
        channelKey: 'alarm_channel',
        title: title,
        body: content,
        notificationLayout: NotificationLayout.Default,
        locked: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        icon: 'resource://drawable/res_logo',
        largeIcon: 'resource://drawable/res_logo',
        payload: additionalInfo,
        showWhen: true,
        category: NotificationCategory.Reminder,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'TAKE',
          label: 'Take',
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'DISMISS',
          label: 'Dismiss',
          autoDismissible: true,
        ),
      ],
      schedule: NotificationCalendar(
        year: tzScheduledTime.year,
        month: tzScheduledTime.month,
        day: tzScheduledTime.day,
        hour: tzScheduledTime.hour,
        minute: tzScheduledTime.minute,
        second: 0,
        millisecond: 0,
        timeZone: timeZoneName,
        repeats: true,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
    );

    print('Notification rescheduled for $dateTime with ID $notificationID');
  } catch (e) {
    print('Failed to reschedule notification: $e');
  }
}
