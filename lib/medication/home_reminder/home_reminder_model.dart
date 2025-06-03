import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_reminder_widget.dart' show HomeReminderWidget;
import 'package:flutter/material.dart';

class HomeReminderModel extends FlutterFlowModel<HomeReminderWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Firestore Query - Query a collection] action in Switch widget.
  IndividualRemindersRecord? specificReminderOff;
  // Stores action output result for [Firestore Query - Query a collection] action in Switch widget.
  IndividualRemindersRecord? specificReminderOn;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
