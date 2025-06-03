import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'diet_home_widget.dart' show DietHomeWidget;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';

class DietHomeModel extends FlutterFlowModel<DietHomeWidget> {
  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? dietWalkthroughController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    dietWalkthroughController?.finish();
  }
}
