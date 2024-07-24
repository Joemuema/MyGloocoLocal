import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'recipecheckout_widget.dart' show RecipecheckoutWidget;
import 'package:flutter/material.dart';

class RecipecheckoutModel extends FlutterFlowModel<RecipecheckoutWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
