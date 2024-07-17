import '/flutter_flow/flutter_flow_util.dart';
import 'edit_reminder_name_widget.dart' show EditReminderNameWidget;
import 'package:flutter/material.dart';

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
