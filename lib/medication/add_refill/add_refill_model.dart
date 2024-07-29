import '/flutter_flow/flutter_flow_util.dart';
import 'add_refill_widget.dart' show AddRefillWidget;
import 'package:flutter/material.dart';

class AddRefillModel extends FlutterFlowModel<AddRefillWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
