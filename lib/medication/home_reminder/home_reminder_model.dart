import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'home_reminder_widget.dart' show HomeReminderWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
