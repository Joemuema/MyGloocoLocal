import '/exercises/corebodyexercisecomponent/corebodyexercisecomponent_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'corebodyexercises_widget.dart' show CorebodyexercisesWidget;
import 'package:flutter/material.dart';

class CorebodyexercisesModel extends FlutterFlowModel<CorebodyexercisesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Models for corebodyexercisecomponent dynamic component.
  late FlutterFlowDynamicModels<CorebodyexercisecomponentModel>
      corebodyexercisecomponentModels;

  @override
  void initState(BuildContext context) {
    corebodyexercisecomponentModels =
        FlutterFlowDynamicModels(() => CorebodyexercisecomponentModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    corebodyexercisecomponentModels.dispose();
  }
}
