import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

int extractDayNumber(DateTime currentDate) {
  return currentDate.day;
}

List<String>? combineTimeLists(
  List<String> specificList,
  List<String> dailyList,
  List<String> weeklyList,
  List<String> monthlyList,
) {
  return List.from(specificList)
    ..addAll(dailyList)
    ..addAll(weeklyList)
    ..addAll(monthlyList);
}

String getDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String getTime(DateTime time) {
  return DateFormat('HH:mm').format(time);
}

List<RemindersRecord>? combineReminderLists(
  List<RemindersRecord> specificList,
  List<RemindersRecord> dailyList,
  List<RemindersRecord> weeklyList,
  List<RemindersRecord> monthlyList,
) {
  return List.from(specificList)
    ..addAll(dailyList)
    ..addAll(weeklyList)
    ..addAll(monthlyList);
}

String getDayofWeek(DateTime date) {
  return DateFormat('EEEE').format(date);
}

String? timestampToDate(DateTimeRange timestamp) {
  DateTime date = timestamp.start;
  return DateFormat('yyyy-MM-dd').format(date);
}

bool isValidDateForCurrentMonth(int day) {
  // Get the current date
  DateTime now = DateTime.now();

  // Get the year and month
  int year = now.year;
  int month = now.month;

  // Create a DateTime object for the first day of the next month
  DateTime firstDayNextMonth = DateTime(year, month + 1, 1);

  // Subtract one day to get the last day of the current month
  DateTime lastDayCurrentMonth = firstDayNextMonth.subtract(Duration(days: 1));

  // Get the last day of the current month
  int lastDay = lastDayCurrentMonth.day;

  // Check if the provided day is valid for the current month
  return day >= 1 && day <= lastDay;
}

int lastDayOfPreviousMonth() {
  // Get the current date
  DateTime now = DateTime.now();

  // Get the year and month
  int year = now.year;
  int month = now.month;

  // Create a DateTime object for the first day of the month
  DateTime firstDayThisMonth = DateTime(year, month, 1);

  // Subtract one day to get the last day of the current month
  DateTime lastDayPreviousMonth = firstDayThisMonth.subtract(Duration(days: 1));

  // return the last day of the previous month
  return lastDayPreviousMonth.day;
}

int getDateNumber(String dateStr) {
  // Define the date format
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  // Parse the string date to DateTime
  DateTime date = dateFormat.parse(dateStr);

  return date.day;
}

int getMonth(String dateString) {
  // Define the date format
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  // Parse the string date to DateTime
  DateTime date = dateFormat.parse(dateString);

  // Extract the month
  return date.month;
}

int getYear(String dateString) {
  // Define the date format
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  // Parse the string date to DateTime
  DateTime date = dateFormat.parse(dateString);

  return date.year;
}

String setWeeklyLastDate(
  String dateString,
  String day,
) {
  String lastDate = dateString;

  Map<String, int> dateInt = {
    'Sunday': 1,
    'Monday': 2,
    'Tuesday': 3,
    'Wednesday': 4,
    'Thursday': 5,
    'Friday': 6,
    'Saturday': 7,
  };

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  int currentDateIndex = dateInt[getDayofWeek(dateFormat.parse(dateString))]!;
  int weeklyDateIndex = dateInt[day]!;
  int dateNumber = getDateNumber(dateString);

  if (currentDateIndex >= weeklyDateIndex) {
    if (dateNumber <= (currentDateIndex - weeklyDateIndex)) {
      lastDate = setDate(getYear(dateString), getMonth(dateString),
          dateNumber - (currentDateIndex - weeklyDateIndex));
    } else {
      lastDate = setDate(
          getYear(dateString),
          getMonth(dateString) - 1,
          lastDayOfPreviousMonth() +
              dateNumber -
              (currentDateIndex - weeklyDateIndex));
    }
  } else {
    lastDate = setDate(getYear(dateString), getMonth(dateString),
        dateNumber + (weeklyDateIndex - currentDateIndex) - 7);
  }

  return lastDate;
}

String setDate(
  int year,
  int month,
  int day,
) {
  // Create a DateTime object from the provided year, month, and day
  DateTime dateTime = DateTime(year, month, day);

  // Format the DateTime object into a string with "yyyy-MM-dd" format
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedDate;
}

String setMonthlyLastDate(
  String dateString,
  int date,
) {
  String lastDate = dateString;

  if (getDateNumber(dateString) >= date) {
    lastDate = setDate(getYear(dateString), getMonth(dateString), date);
  } else {
    lastDate = setDate(getYear(dateString), getMonth(dateString) - 1, date);
  }

  return lastDate;
}

DateTime incrementDate(DateTime currentDate) {
  return currentDate.add(Duration(days: 1));
}

DateTime decrementDate(DateTime currentDate) {
  return currentDate.subtract(Duration(days: 1));
}

String convertChartDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

DateTime stringToDate(String dateString) {
  return DateTime.parse(dateString);
}

DateTime currentDate(DateTime currentTime) {
  return DateTime(currentTime.year, currentTime.month, currentTime.day);
}

DateTime commonTimeDT(DateTime currentTime) {
  DateTime now = DateTime.now();

  DateTime commonTime =
      DateTime(now.year, 1, 1, currentTime.hour, currentTime.minute);

  print('CommonDT = $commonTime');

  return commonTime;
}

DateTime todayTime(String time) {
  DateTime parsedTime = DateFormat('HH:mm').parse(time);
  DateTime now = DateTime.now();

  parsedTime = DateTime(
      now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

  return parsedTime;
}

double stringToDouble(String doubleString) {
  double number = 0;

  try {
    number = double.parse(doubleString);
  } catch (e) {
    print("Error: ${e.toString()}");
  }

  return number;
}

int getHour(DateTime time) {
  return time.hour;
}

int getMinute(DateTime time) {
  return time.minute;
}

DateTime currentTimeXHoursBack(
  DateTime currentTime,
  double hours,
) {
  final totalMinutes = (hours * 60).toInt();
  final duration = Duration(minutes: totalMinutes);
  return currentTime.subtract(duration);
}

List<IndividualRemindersRecord> combineIndividualReminders(
  List<IndividualRemindersRecord> pastIndividualReminders,
  List<IndividualRemindersRecord> todayIndividualReminders,
) {
  return List.from(pastIndividualReminders)..addAll(todayIndividualReminders);
}

double avgSugarReadings(List<double> readings) {
  double total = 0.0;
  int count = 0;

  for (double reading in readings) {
    total += reading;
    count++;
  }

  if (count == 0) {
    return 0.0;
  }

  double avg = total / count;
  return double.parse(avg.toStringAsFixed(2));
}

double calcTotalKcal(List<double> kcalValues) {
  double total = 0.0;

  for (double value in kcalValues) {
    total += value;
  }

  return double.parse(total.toStringAsFixed(2));
}

List<double> lowestAndHighestChartTimeValues(
  List<double> beforeMealTimeValues,
  List<double> afterMealTimeValues,
) {
// Combine both lists into one
  final combined = <double>[
    ...beforeMealTimeValues,
    ...afterMealTimeValues,
  ];

  if (combined.isEmpty) {
    return [0.0, 24.0];
  }

  // Find the lowest and highest values
  double minValue = combined.reduce((a, b) => a < b ? a : b);
  double maxValue = combined.reduce((a, b) => a > b ? a : b);

  return [minValue, maxValue];
}

DateTime incrementWeek(DateTime currentDate) {
  return currentDate.add(Duration(days: 7));
}

DateTime decrementWeek(DateTime currentDate) {
  return currentDate.subtract(Duration(days: 7));
}

DateTime incrementMonth(DateTime currentDate) {
  return DateTime(
    currentDate.year,
    currentDate.month + 1,
    currentDate.day,
    currentDate.hour,
    currentDate.minute,
    currentDate.second,
    currentDate.millisecond,
    currentDate.microsecond,
  );
}

DateTime decrementMonth(DateTime currentDate) {
  return DateTime(
    currentDate.year,
    currentDate.month - 1,
    currentDate.day,
    currentDate.hour,
    currentDate.minute,
    currentDate.second,
    currentDate.millisecond,
    currentDate.microsecond,
  );
}

DateTime firstDayOfWeek(DateTime date) {
  final daysToSubtract = date.weekday % 7;
  return date.subtract(Duration(days: daysToSubtract));
}

DateTime lastDayOfWeek(DateTime date) {
  final daysToAdd = 6 - (date.weekday % 7);
  return date.add(Duration(days: daysToAdd));
}

DateTime firstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime lastDayOfMonth(DateTime date) {
  final firstOfNextMonth = (date.month < 12)
      ? DateTime(date.year, date.month + 1, 1)
      : DateTime(date.year + 1, 1, 1);
  return firstOfNextMonth.subtract(Duration(days: 1));
}

List<double> mgdlToMmol(List<double> mgdlValues) {
  return mgdlValues.map((v) => v / 18.018).toList();
}

List<double> convertToWeekTimes(List<BGreadingsRecord> docs) {
  final List<double> resultList = [];

  for (final doc in docs) {
    try {
      final DateTime? date = doc.dateTime;
      final double? decimalTime = doc.decimalTime;

      if (date != null && decimalTime != null) {
        // Week of the month (1 to 5)
        // Compute weekday index: Sunday = 0, Monday = 1, ..., Saturday = 6
        final int dayIndex = (date.weekday % 7);

        // Normalize decimal time between 0 and 1
        final double timePortion = decimalTime / 24.0;

        // Compute final value and add to list
        resultList.add(dayIndex + timePortion);
      }
    } catch (e) {
      continue;
    }
  }

  return resultList;
}

List<double> convertToMonthTimes(List<BGreadingsRecord> docs) {
  final List<double> results = [];

  for (final doc in docs) {
    try {
      final DateTime? date = doc.dateTime;
      final double? decimalTime = doc.decimalTime;

      if (date != null && decimalTime != null) {
        // Week of the month (1-based index)
        final int dayOfMonth = date.day;
        final int weekOfMonth = ((dayOfMonth - 1) ~/ 7) + 1;

        // Day of week: Sunday = 0, Monday = 1, ..., Saturday = 6
        final int dayOfWeekIndex = date.weekday % 7;

        // Combined decimal time: [(day index * 24) + decimalTime]/168
        final double timeValue = ((dayOfWeekIndex * 24) + decimalTime) / 168.0;

        // Final value = weekOfMonth + timeValue
        results.add(weekOfMonth + timeValue);
      }
    } catch (e) {
      // Skip any document with missing or invalid data
      continue;
    }
  }

  return results;
}

List<double> xChartBounds(
  List<double> beforeMealTimeValues,
  List<double> afterMealTimeValues,
  String interval,
) {
  // Combine both lists into one
  final combined = <double>[
    ...beforeMealTimeValues,
    ...afterMealTimeValues,
  ];

  if (combined.isEmpty) {
    if (interval == 'daily') {
      return [0.0, 24.0];
    } else if (interval == 'weekly') {
      return [0.0, 7.0];
    } else if (interval == 'monthly') {
      return [0.0, 4.0];
    } else {
      return [0.0, 1.0]; // Default fallback for unknown intervals
    }
  }

  // Find the lowest and highest values
  double minValue = combined.reduce((a, b) => a < b ? a : b);
  double maxValue = combined.reduce((a, b) => a > b ? a : b);

  return [minValue, maxValue];
}

String monthName(DateTime date) {
  const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  return monthNames[date.month - 1];
}
