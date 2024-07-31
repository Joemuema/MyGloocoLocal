import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'access_from_main_tab_widget.dart' show AccessFromMainTabWidget;
import 'package:flutter/material.dart';

class AccessFromMainTabModel extends FlutterFlowModel<AccessFromMainTabWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for Foodentrys widget.
  FocusNode? foodentrysFocusNode;
  TextEditingController? foodentrysTextController;
  String? Function(BuildContext, String?)? foodentrysTextControllerValidator;
  String? _foodentrysTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    foodentrysTextControllerValidator = _foodentrysTextControllerValidator;
  }

  @override
  void dispose() {
    foodentrysFocusNode?.dispose();
    foodentrysTextController?.dispose();
  }
}
