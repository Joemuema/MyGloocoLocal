import '/backend/backend.dart';
import '/components/home_reminder_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'medication_home_widget.dart' show MedicationHomeWidget;
import 'package:flutter/material.dart';

class MedicationHomeModel extends FlutterFlowModel<MedicationHomeWidget> {
  ///  Local state fields for this page.

  List<String> listOfTimes = [];
  void addToListOfTimes(String item) => listOfTimes.add(item);
  void removeFromListOfTimes(String item) => listOfTimes.remove(item);
  void removeAtIndexFromListOfTimes(int index) => listOfTimes.removeAt(index);
  void insertAtIndexInListOfTimes(int index, String item) =>
      listOfTimes.insert(index, item);
  void updateListOfTimesAtIndex(int index, Function(String) updateFn) =>
      listOfTimes[index] = updateFn(listOfTimes[index]);

  List<RemindersRecord> filteredReminders = [];
  void addToFilteredReminders(RemindersRecord item) =>
      filteredReminders.add(item);
  void removeFromFilteredReminders(RemindersRecord item) =>
      filteredReminders.remove(item);
  void removeAtIndexFromFilteredReminders(int index) =>
      filteredReminders.removeAt(index);
  void insertAtIndexInFilteredReminders(int index, RemindersRecord item) =>
      filteredReminders.insert(index, item);
  void updateFilteredRemindersAtIndex(
          int index, Function(RemindersRecord) updateFn) =>
      filteredReminders[index] = updateFn(filteredReminders[index]);

  String selectedDay = 'none';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in MedicationHome widget.
  List<RemindersRecord>? allReminders;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<RemindersRecord>? calendarReminders;
  // Models for homeReminder dynamic component.
  late FlutterFlowDynamicModels<HomeReminderModel> homeReminderModels;
  DateTime? datePicked;

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
