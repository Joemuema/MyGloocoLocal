import '/flutter_flow/flutter_flow_util.dart';
import 'manual_food_widget.dart' show ManualFoodWidget;
import 'package:flutter/material.dart';

class ManualFoodModel extends FlutterFlowModel<ManualFoodWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Manualfood widget.
  FocusNode? manualfoodFocusNode;
  TextEditingController? manualfoodTextController;
  String? Function(BuildContext, String?)? manualfoodTextControllerValidator;
  String? _manualfoodTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Food entry is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    manualfoodTextControllerValidator = _manualfoodTextControllerValidator;
  }

  @override
  void dispose() {
    manualfoodFocusNode?.dispose();
    manualfoodTextController?.dispose();
  }
}
