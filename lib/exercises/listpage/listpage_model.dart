import '/exercises/highintensitylistcomponents/highintensitylistcomponents_widget.dart';
import '/exercises/lowintensitylistcomponent/lowintensitylistcomponent_widget.dart';
import '/exercises/mediumsintensitylistcomponent/mediumsintensitylistcomponent_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'listpage_widget.dart' show ListpageWidget;
import 'package:flutter/material.dart';

class ListpageModel extends FlutterFlowModel<ListpageWidget> {
  ///  State fields for stateful widgets in this page.

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
    lowintensitylistcomponentModels.dispose();
    mediumsintensitylistcomponentModels.dispose();
    highintensitylistcomponentsModels.dispose();
  }
}
