import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  DateTime? currentChartDate;

  double? bloodSugarAvg = 0.0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<BGreadingsRecord>? todayReadings;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<IndividualRemindersRecord>? unmarkedReminders;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? prevDayReadings;
  DateTime? datePicked;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BGreadingsRecord>? nextDayReadings;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
