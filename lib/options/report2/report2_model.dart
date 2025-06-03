import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'report2_widget.dart' show Report2Widget;
import 'package:flutter/material.dart';

class Report2Model extends FlutterFlowModel<Report2Widget> {
  ///  State fields for stateful widgets in this component.

  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;
  // Stores action output result for [Custom Action - generateReport] action in Button widget.
  String? maybe;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
