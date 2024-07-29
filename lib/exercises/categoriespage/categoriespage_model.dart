import '/backend/backend.dart';
import '/components/flexibilityexercisecomponent_widget.dart';
import '/exercises/aerobicexerciseexplanantion/aerobicexerciseexplanantion_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'categoriespage_widget.dart' show CategoriespageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriespageModel extends FlutterFlowModel<CategoriespageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
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
    unfocusNode.dispose();
    tabBarController?.dispose();
    flexibilityexercisecomponentModels.dispose();
  }
}
