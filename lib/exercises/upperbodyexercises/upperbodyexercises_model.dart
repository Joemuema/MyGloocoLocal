import '/backend/backend.dart';
import '/components/upperbodycomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'upperbodyexercises_widget.dart' show UpperbodyexercisesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpperbodyexercisesModel
    extends FlutterFlowModel<UpperbodyexercisesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Models for upperbodycomponent dynamic component.
  late FlutterFlowDynamicModels<UpperbodycomponentModel>
      upperbodycomponentModels;

  @override
  void initState(BuildContext context) {
    upperbodycomponentModels =
        FlutterFlowDynamicModels(() => UpperbodycomponentModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    upperbodycomponentModels.dispose();
  }
}
