import '/exercises/upperbodycomponent/upperbodycomponent_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'upperbodyexercises_widget.dart' show UpperbodyexercisesWidget;
import 'package:flutter/material.dart';

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
