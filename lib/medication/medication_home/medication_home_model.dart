import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/medication/home_reminder/home_reminder_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import '/index.dart';
import 'medication_home_widget.dart' show MedicationHomeWidget;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
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

  String today = 'date';

  String calendarDate = 'date';

  List<IndividualRemindersRecord> pastMissedIndividualReminders = [];
  void addToPastMissedIndividualReminders(IndividualRemindersRecord item) =>
      pastMissedIndividualReminders.add(item);
  void removeFromPastMissedIndividualReminders(
          IndividualRemindersRecord item) =>
      pastMissedIndividualReminders.remove(item);
  void removeAtIndexFromPastMissedIndividualReminders(int index) =>
      pastMissedIndividualReminders.removeAt(index);
  void insertAtIndexInPastMissedIndividualReminders(
          int index, IndividualRemindersRecord item) =>
      pastMissedIndividualReminders.insert(index, item);
  void updatePastMissedIndividualRemindersAtIndex(
          int index, Function(IndividualRemindersRecord) updateFn) =>
      pastMissedIndividualReminders[index] =
          updateFn(pastMissedIndividualReminders[index]);

  List<IndividualRemindersRecord> todayMIssedIndividualReminders = [];
  void addToTodayMIssedIndividualReminders(IndividualRemindersRecord item) =>
      todayMIssedIndividualReminders.add(item);
  void removeFromTodayMIssedIndividualReminders(
          IndividualRemindersRecord item) =>
      todayMIssedIndividualReminders.remove(item);
  void removeAtIndexFromTodayMIssedIndividualReminders(int index) =>
      todayMIssedIndividualReminders.removeAt(index);
  void insertAtIndexInTodayMIssedIndividualReminders(
          int index, IndividualRemindersRecord item) =>
      todayMIssedIndividualReminders.insert(index, item);
  void updateTodayMIssedIndividualRemindersAtIndex(
          int index, Function(IndividualRemindersRecord) updateFn) =>
      todayMIssedIndividualReminders[index] =
          updateFn(todayMIssedIndividualReminders[index]);

  bool expandedCalendar = false;

  bool calendarChanged = false;

  DateTime? calendarDateTime;

  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? medWalkthroughController;
  // Stores action output result for [Firestore Query - Query a collection] action in MedicationHome widget.
  List<RemindersRecord>? allReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in MedicationHome widget.
  List<IndividualRemindersRecord>? currentSubReminders;
  // Stores action output result for [Custom Action - requestPermissions] action in MedicationHome widget.
  bool? permissionsGranted;
  // Stores action output result for [Firestore Query - Query a collection] action in MedicationHome widget.
  List<MedicineRecord>? lowCapacityMeds;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay1;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<RemindersRecord>? exCalendarReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<IndividualRemindersRecord>? exTodaySubReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<IndividualRemindersRecord>? exCalendarSubReminders;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay2;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<RemindersRecord>? calendarReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<IndividualRemindersRecord>? todaySubReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  List<IndividualRemindersRecord>? calendarSubReminders;
  DateTime? datePicked;
  // Models for homeReminder dynamic component.
  late FlutterFlowDynamicModels<HomeReminderModel> homeReminderModels;
  // Model for noElements component.
  late NoElementsModel noElementsModel1;
  // Model for noElements component.
  late NoElementsModel noElementsModel2;
  // Model for noElements component.
  late NoElementsModel noElementsModel3;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay1 = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    calendarSelectedDay2 = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    homeReminderModels = FlutterFlowDynamicModels(() => HomeReminderModel());
    noElementsModel1 = createModel(context, () => NoElementsModel());
    noElementsModel2 = createModel(context, () => NoElementsModel());
    noElementsModel3 = createModel(context, () => NoElementsModel());
  }

  @override
  void dispose() {
    medWalkthroughController?.finish();
    homeReminderModels.dispose();
    noElementsModel1.dispose();
    noElementsModel2.dispose();
    noElementsModel3.dispose();
  }
}
