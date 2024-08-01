import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'addactivity_widget.dart' show AddactivityWidget;
import 'package:flutter/material.dart';

class AddactivityModel extends FlutterFlowModel<AddactivityWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ActivitTextField widget.
  FocusNode? activitTextFieldFocusNode;
  TextEditingController? activitTextFieldTextController;
  String? Function(BuildContext, String?)?
      activitTextFieldTextControllerValidator;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue;
  // State field(s) for DistanceTextField widget.
  FocusNode? distanceTextFieldFocusNode;
  TextEditingController? distanceTextFieldTextController;
  String? Function(BuildContext, String?)?
      distanceTextFieldTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // State field(s) for intensitychoicechips widget.
  FormFieldController<List<String>>? intensitychoicechipsValueController;
  String? get intensitychoicechipsValue =>
      intensitychoicechipsValueController?.value?.firstOrNull;
  set intensitychoicechipsValue(String? val) =>
      intensitychoicechipsValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    activitTextFieldFocusNode?.dispose();
    activitTextFieldTextController?.dispose();

    distanceTextFieldFocusNode?.dispose();
    distanceTextFieldTextController?.dispose();
  }
}
