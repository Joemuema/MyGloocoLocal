import '/backend/backend.dart';
import '/components/home_reminder_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'medication_home_widget.dart' show MedicationHomeWidget;
import 'package:flutter/material.dart';

class MedicationHomeModel extends FlutterFlowModel<MedicationHomeWidget> {
  ///  Local state fields for this page.

  List<String> listOfUpcomingTimes = [];
  void addToListOfUpcomingTimes(String item) => listOfUpcomingTimes.add(item);
  void removeFromListOfUpcomingTimes(String item) =>
      listOfUpcomingTimes.remove(item);
  void removeAtIndexFromListOfUpcomingTimes(int index) =>
      listOfUpcomingTimes.removeAt(index);
  void insertAtIndexInListOfUpcomingTimes(int index, String item) =>
      listOfUpcomingTimes.insert(index, item);
  void updateListOfUpcomingTimesAtIndex(int index, Function(String) updateFn) =>
      listOfUpcomingTimes[index] = updateFn(listOfUpcomingTimes[index]);

  List<RemindersRecord> upcomingReminders = [];
  void addToUpcomingReminders(RemindersRecord item) =>
      upcomingReminders.add(item);
  void removeFromUpcomingReminders(RemindersRecord item) =>
      upcomingReminders.remove(item);
  void removeAtIndexFromUpcomingReminders(int index) =>
      upcomingReminders.removeAt(index);
  void insertAtIndexInUpcomingReminders(int index, RemindersRecord item) =>
      upcomingReminders.insert(index, item);
  void updateUpcomingRemindersAtIndex(
          int index, Function(RemindersRecord) updateFn) =>
      upcomingReminders[index] = updateFn(upcomingReminders[index]);

  String selectedDay = 'none';

  List<String> listOfTakenTimes = [];
  void addToListOfTakenTimes(String item) => listOfTakenTimes.add(item);
  void removeFromListOfTakenTimes(String item) => listOfTakenTimes.remove(item);
  void removeAtIndexFromListOfTakenTimes(int index) =>
      listOfTakenTimes.removeAt(index);
  void insertAtIndexInListOfTakenTimes(int index, String item) =>
      listOfTakenTimes.insert(index, item);
  void updateListOfTakenTimesAtIndex(int index, Function(String) updateFn) =>
      listOfTakenTimes[index] = updateFn(listOfTakenTimes[index]);

  List<IndividualRemindersRecord> takenReminders = [];
  void addToTakenReminders(IndividualRemindersRecord item) =>
      takenReminders.add(item);
  void removeFromTakenReminders(IndividualRemindersRecord item) =>
      takenReminders.remove(item);
  void removeAtIndexFromTakenReminders(int index) =>
      takenReminders.removeAt(index);
  void insertAtIndexInTakenReminders(
          int index, IndividualRemindersRecord item) =>
      takenReminders.insert(index, item);
  void updateTakenRemindersAtIndex(
          int index, Function(IndividualRemindersRecord) updateFn) =>
      takenReminders[index] = updateFn(takenReminders[index]);

  List<String> listOfMissedTimes = [];
  void addToListOfMissedTimes(String item) => listOfMissedTimes.add(item);
  void removeFromListOfMissedTimes(String item) =>
      listOfMissedTimes.remove(item);
  void removeAtIndexFromListOfMissedTimes(int index) =>
      listOfMissedTimes.removeAt(index);
  void insertAtIndexInListOfMissedTimes(int index, String item) =>
      listOfMissedTimes.insert(index, item);
  void updateListOfMissedTimesAtIndex(int index, Function(String) updateFn) =>
      listOfMissedTimes[index] = updateFn(listOfMissedTimes[index]);

  List<IndividualRemindersRecord> missedReminders = [];
  void addToMissedReminders(IndividualRemindersRecord item) =>
      missedReminders.add(item);
  void removeFromMissedReminders(IndividualRemindersRecord item) =>
      missedReminders.remove(item);
  void removeAtIndexFromMissedReminders(int index) =>
      missedReminders.removeAt(index);
  void insertAtIndexInMissedReminders(
          int index, IndividualRemindersRecord item) =>
      missedReminders.insert(index, item);
  void updateMissedRemindersAtIndex(
          int index, Function(IndividualRemindersRecord) updateFn) =>
      missedReminders[index] = updateFn(missedReminders[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in MedicationHome widget.
  List<RemindersRecord>? allReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in MedicationHome widget.
  List<IndividualRemindersRecord>? currentSubReminders;
  // Stores action output result for [Custom Action - requestPermissions] action in MedicationHome widget.
  bool? permissionsGranted;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<RemindersRecord>? calendarReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<IndividualRemindersRecord>? todaySubReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<IndividualRemindersRecord>? calendarSubReminders;
  // Models for homeReminder dynamic component.
  late FlutterFlowDynamicModels<HomeReminderModel> homeReminderModels;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    homeReminderModels = FlutterFlowDynamicModels(() => HomeReminderModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    homeReminderModels.dispose();
  }
}
