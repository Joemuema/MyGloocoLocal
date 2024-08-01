import '/backend/backend.dart';
import '/exercises/lowerbodyexercisescomponents/lowerbodyexercisescomponents_widget.dart';
import '/exercises/strengthexercises/strengthexercises_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'lowerbodyexercise_widget.dart' show LowerbodyexerciseWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LowerbodyexerciseModel extends FlutterFlowModel<LowerbodyexerciseWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
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
    unfocusNode.dispose();
    lowerbodyexercisescomponentsModels.dispose();
  }
}
