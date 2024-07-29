import '/backend/backend.dart';
import '/components/highintensitylistcomponents_widget.dart';
import '/components/lowintensitylistcomponent_widget.dart';
import '/exercises/mediumsintensitylistcomponent/mediumsintensitylistcomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'listpage_widget.dart' show ListpageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListpageModel extends FlutterFlowModel<ListpageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Models for lowintensitylistcomponent dynamic component.
  late FlutterFlowDynamicModels<LowintensitylistcomponentModel>
      lowintensitylistcomponentModels;
  // Models for mediumsintensitylistcomponent dynamic component.
  late FlutterFlowDynamicModels<MediumsintensitylistcomponentModel>
      mediumsintensitylistcomponentModels;
  // Models for highintensitylistcomponents dynamic component.
  late FlutterFlowDynamicModels<HighintensitylistcomponentsModel>
      highintensitylistcomponentsModels;

  @override
  void initState(BuildContext context) {
    lowintensitylistcomponentModels =
        FlutterFlowDynamicModels(() => LowintensitylistcomponentModel());
    mediumsintensitylistcomponentModels =
        FlutterFlowDynamicModels(() => MediumsintensitylistcomponentModel());
    highintensitylistcomponentsModels =
        FlutterFlowDynamicModels(() => HighintensitylistcomponentsModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    lowintensitylistcomponentModels.dispose();
    mediumsintensitylistcomponentModels.dispose();
    highintensitylistcomponentsModels.dispose();
  }
}
