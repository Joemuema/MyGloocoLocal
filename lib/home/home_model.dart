import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  DateTime? currentChartDate;

  double? bloodSugarAvg = 0.0;

  List<double> mgdlUpperYBounds = [180.0, 180.0];
  void addToMgdlUpperYBounds(double item) => mgdlUpperYBounds.add(item);
  void removeFromMgdlUpperYBounds(double item) => mgdlUpperYBounds.remove(item);
  void removeAtIndexFromMgdlUpperYBounds(int index) =>
      mgdlUpperYBounds.removeAt(index);
  void insertAtIndexInMgdlUpperYBounds(int index, double item) =>
      mgdlUpperYBounds.insert(index, item);
  void updateMgdlUpperYBoundsAtIndex(int index, Function(double) updateFn) =>
      mgdlUpperYBounds[index] = updateFn(mgdlUpperYBounds[index]);

  List<double> mgdlLowerYBounds = [70.0, 70.0];
  void addToMgdlLowerYBounds(double item) => mgdlLowerYBounds.add(item);
  void removeFromMgdlLowerYBounds(double item) => mgdlLowerYBounds.remove(item);
  void removeAtIndexFromMgdlLowerYBounds(int index) =>
      mgdlLowerYBounds.removeAt(index);
  void insertAtIndexInMgdlLowerYBounds(int index, double item) =>
      mgdlLowerYBounds.insert(index, item);
  void updateMgdlLowerYBoundsAtIndex(int index, Function(double) updateFn) =>
      mgdlLowerYBounds[index] = updateFn(mgdlLowerYBounds[index]);

  List<double> xBounds = [0.0, 24.0];
  void addToXBounds(double item) => xBounds.add(item);
  void removeFromXBounds(double item) => xBounds.remove(item);
  void removeAtIndexFromXBounds(int index) => xBounds.removeAt(index);
  void insertAtIndexInXBounds(int index, double item) =>
      xBounds.insert(index, item);
  void updateXBoundsAtIndex(int index, Function(double) updateFn) =>
      xBounds[index] = updateFn(xBounds[index]);

  List<BGreadingsRecord> dayReadings = [];
  void addToDayReadings(BGreadingsRecord item) => dayReadings.add(item);
  void removeFromDayReadings(BGreadingsRecord item) => dayReadings.remove(item);
  void removeAtIndexFromDayReadings(int index) => dayReadings.removeAt(index);
  void insertAtIndexInDayReadings(int index, BGreadingsRecord item) =>
      dayReadings.insert(index, item);
  void updateDayReadingsAtIndex(
          int index, Function(BGreadingsRecord) updateFn) =>
      dayReadings[index] = updateFn(dayReadings[index]);

  List<BGreadingsRecord> weekReadings = [];
  void addToWeekReadings(BGreadingsRecord item) => weekReadings.add(item);
  void removeFromWeekReadings(BGreadingsRecord item) =>
      weekReadings.remove(item);
  void removeAtIndexFromWeekReadings(int index) => weekReadings.removeAt(index);
  void insertAtIndexInWeekReadings(int index, BGreadingsRecord item) =>
      weekReadings.insert(index, item);
  void updateWeekReadingsAtIndex(
          int index, Function(BGreadingsRecord) updateFn) =>
      weekReadings[index] = updateFn(weekReadings[index]);

  List<BGreadingsRecord> monthReadings = [];
  void addToMonthReadings(BGreadingsRecord item) => monthReadings.add(item);
  void removeFromMonthReadings(BGreadingsRecord item) =>
      monthReadings.remove(item);
  void removeAtIndexFromMonthReadings(int index) =>
      monthReadings.removeAt(index);
  void insertAtIndexInMonthReadings(int index, BGreadingsRecord item) =>
      monthReadings.insert(index, item);
  void updateMonthReadingsAtIndex(
          int index, Function(BGreadingsRecord) updateFn) =>
      monthReadings[index] = updateFn(monthReadings[index]);

  List<double> mmolUpperYBounds = [9.99, 9.99];
  void addToMmolUpperYBounds(double item) => mmolUpperYBounds.add(item);
  void removeFromMmolUpperYBounds(double item) => mmolUpperYBounds.remove(item);
  void removeAtIndexFromMmolUpperYBounds(int index) =>
      mmolUpperYBounds.removeAt(index);
  void insertAtIndexInMmolUpperYBounds(int index, double item) =>
      mmolUpperYBounds.insert(index, item);
  void updateMmolUpperYBoundsAtIndex(int index, Function(double) updateFn) =>
      mmolUpperYBounds[index] = updateFn(mmolUpperYBounds[index]);

  List<double> mmolLowerYBounds = [3.885, 3.885];
  void addToMmolLowerYBounds(double item) => mmolLowerYBounds.add(item);
  void removeFromMmolLowerYBounds(double item) => mmolLowerYBounds.remove(item);
  void removeAtIndexFromMmolLowerYBounds(int index) =>
      mmolLowerYBounds.removeAt(index);
  void insertAtIndexInMmolLowerYBounds(int index, double item) =>
      mmolLowerYBounds.insert(index, item);
  void updateMmolLowerYBoundsAtIndex(int index, Function(double) updateFn) =>
      mmolLowerYBounds[index] = updateFn(mmolLowerYBounds[index]);

  bool rebuild = false;

  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? homePageWalkthroughController;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<BGreadingsRecord>? todayReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<BGreadingsRecord>? thisWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<BGreadingsRecord>? pastWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<BGreadingsRecord>? thisMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<BGreadingsRecord>? pastMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<IndividualRemindersRecord>? unmarkedReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? refreshFullMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? refreshMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? refreshFullWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? refreshWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? refreshDayReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? decrementDayReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? decrementWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? decrementFullWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? decrementMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? decrementFullMonthReadings;
  DateTime? datePicked;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? newTodayReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? newWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? newPastWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? newMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BGreadingsRecord>? newPastMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? incrementTodayReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? incrementWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? incrementFullWeekReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? incrementMonthReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? incrementFullMonthReadings;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    homePageWalkthroughController?.finish();
  }
}
