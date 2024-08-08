import '/exercises/flexibilityexercisecomponent/flexibilityexercisecomponent_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'categoriespage_widget.dart' show CategoriespageWidget;
import 'package:flutter/material.dart';

class CategoriespageModel extends FlutterFlowModel<CategoriespageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Models for flexibilityexercisecomponent dynamic component.
  late FlutterFlowDynamicModels<FlexibilityexercisecomponentModel>
      flexibilityexercisecomponentModels;

  @override
  void initState(BuildContext context) {
    flexibilityexercisecomponentModels =
        FlutterFlowDynamicModels(() => FlexibilityexercisecomponentModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    flexibilityexercisecomponentModels.dispose();
  }
}
