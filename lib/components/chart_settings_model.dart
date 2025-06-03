import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'chart_settings_widget.dart' show ChartSettingsWidget;
import 'package:flutter/material.dart';

class ChartSettingsModel extends FlutterFlowModel<ChartSettingsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ChartTypeDropDown widget.
  String? chartTypeDropDownValue;
  FormFieldController<String>? chartTypeDropDownValueController;
  // State field(s) for DurationDropDown widget.
  String? durationDropDownValue;
  FormFieldController<String>? durationDropDownValueController;
  // State field(s) for UnitsDropDown widget.
  String? unitsDropDownValue;
  FormFieldController<String>? unitsDropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
