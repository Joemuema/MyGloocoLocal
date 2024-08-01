import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'edit_reminder_name_widget.dart' show EditReminderNameWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditReminderNameModel extends FlutterFlowModel<EditReminderNameWidget> {
  ///  Local state fields for this component.

  String editedName = 'reminderName';

  ///  State fields for stateful widgets in this component.

  // State field(s) for reminderNameText widget.
  FocusNode? reminderNameTextFocusNode;
  TextEditingController? reminderNameTextTextController;
  String? Function(BuildContext, String?)?
      reminderNameTextTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reminderNameTextFocusNode?.dispose();
    reminderNameTextTextController?.dispose();
  }
}
