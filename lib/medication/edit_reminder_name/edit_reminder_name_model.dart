import '/flutter_flow/flutter_flow_util.dart';
import 'edit_reminder_name_widget.dart' show EditReminderNameWidget;
import 'package:flutter/material.dart';

class EditReminderNameModel extends FlutterFlowModel<EditReminderNameWidget> {
  ///  Local state fields for this component.

  String editedName = 'reminderName';

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for reminderNameText widget.
  FocusNode? reminderNameTextFocusNode;
  TextEditingController? reminderNameTextTextController;
  String? Function(BuildContext, String?)?
      reminderNameTextTextControllerValidator;
  String? _reminderNameTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Reminder\'s name is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    reminderNameTextTextControllerValidator =
        _reminderNameTextTextControllerValidator;
  }

  @override
  void dispose() {
    reminderNameTextFocusNode?.dispose();
    reminderNameTextTextController?.dispose();
  }
}
