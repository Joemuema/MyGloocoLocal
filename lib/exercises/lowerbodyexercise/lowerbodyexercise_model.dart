import '/exercises/lowerbodyexercisescomponents/lowerbodyexercisescomponents_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lowerbodyexercise_widget.dart' show LowerbodyexerciseWidget;
import 'package:flutter/material.dart';

class LowerbodyexerciseModel extends FlutterFlowModel<LowerbodyexerciseWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for lowerbodyexercisescomponents dynamic component.
  late FlutterFlowDynamicModels<LowerbodyexercisescomponentsModel>
      lowerbodyexercisescomponentsModels;

  @override
  void initState(BuildContext context) {
    lowerbodyexercisescomponentsModels =
        FlutterFlowDynamicModels(() => LowerbodyexercisescomponentsModel());
  }

  @override
  void dispose() {
    lowerbodyexercisescomponentsModels.dispose();
  }
}
