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
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

Future scheduleAlarmNotification(
  String title,
  String content,
  String time,
  String frequency,
  DateTime startDate,
  DateTime endDate,
  DocumentReference reminderID,
) async {
  tzdata.initializeTimeZones();

  DateTime parsedTime = DateFormat('HH:mm').parse(time);
  DateTime now = DateTime.now();

  parsedTime = DateTime(
      now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

  String timeZoneName = await FlutterTimezone.getLocalTimezone();

  final tzLocation = tz.getLocation(timeZoneName);

  int notificationId;
  int advanceDay = 0;
  int advanceMonth = 0;

  CollectionReference individualReminders = FirebaseFirestore.instance
      .collection('Reminders')
      .doc(reminderID.path)
      .collection('IndividualReminders');

  if (frequency == 'Daily' || frequency == 'Once') {
    advanceDay = 1;
  } else if (frequency == 'Weekly') {
    advanceDay = 7;
  } else if (frequency == 'Monthly') {
    advanceMonth = 1;
  }

  DateTime currentDate = startDate;
  DateTime lastDate = endDate;

  while (currentDate.isBefore(lastDate)) {
    DateTime scheduledTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    var tzScheduledTime = tz.TZDateTime.from(scheduledTime, tzLocation);

    if (tzScheduledTime.isBefore(tz.TZDateTime.now(tzLocation))) {
      print('Scheduled time is in the past: $tzScheduledTime');
    } else {
      notificationId = await getNextNotificationId();

      QuerySnapshot querySnapshot = await individualReminders
          .where('Date', isEqualTo: getDate(currentDate))
          .where('Time', isEqualTo: time!)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({'NotificationID': notificationId});
        await docRef.update({'Title': title});
        await docRef.update({'NotificationID': content});
      }

      Map<String, String?> additionalInfo = {
        'Date': getDate(currentDate),
        'Time': time!,
        'ReminderID': reminderID.path,
      };

      // String payload = jsonEncode(additionalInfo);

      try {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: notificationId,
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

        print(
            'Notification scheduled for $scheduledTime with ID $notificationId');
      } catch (e) {
        print('Failed to schedule notification: $e');
      }
    }

    currentDate = DateTime(currentDate.year, currentDate.month + advanceMonth,
        currentDate.day + advanceDay);
  }
}
