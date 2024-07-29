import '/backend/backend.dart';
import '/exercises/corebodyexercisecomponent/corebodyexercisecomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'corebodyexercises_widget.dart' show CorebodyexercisesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
