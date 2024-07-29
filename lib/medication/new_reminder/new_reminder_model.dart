import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/medication/edit_reminder_name/edit_reminder_name_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'new_reminder_widget.dart' show NewReminderWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewReminderModel extends FlutterFlowModel<NewReminderWidget> {
  ///  Local state fields for this component.

  String currentReminderName = 'Reminder';

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Bottom Sheet - EditReminderName] action in Icon widget.
  String? reminderName;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for frequency widget.
  String? frequencyValue;
  FormFieldController<String>? frequencyValueController;
  // State field(s) for weekDayList widget.
  String? weekDayListValue;
  FormFieldController<String>? weekDayListValueController;
  // State field(s) for DateField widget.
  FocusNode? dateFieldFocusNode;
  TextEditingController? dateFieldTextController;
  String? Function(BuildContext, String?)? dateFieldTextControllerValidator;
  DateTime? datePicked1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  DateTime? datePicked2;
  DateTime? datePicked3;
  DateTime? datePicked4;
  DateTime? datePicked5;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    dateFieldFocusNode?.dispose();
    dateFieldTextController?.dispose();
  }
}
