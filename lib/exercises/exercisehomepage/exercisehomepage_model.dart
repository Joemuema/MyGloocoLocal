import '/exercises/exercisetaskstodaycomponent/exercisetaskstodaycomponent_widget.dart';
import '/exercises/incompleteactivitylist/incompleteactivitylist_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'exercisehomepage_widget.dart' show ExercisehomepageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';

class ExercisehomepageModel extends FlutterFlowModel<ExercisehomepageWidget> {
  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? exerciseWalkthroughController;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // Models for incompleteactivitylist dynamic component.
  late FlutterFlowDynamicModels<IncompleteactivitylistModel>
      incompleteactivitylistModels;
  // Models for exercisetaskstodaycomponent dynamic component.
  late FlutterFlowDynamicModels<ExercisetaskstodaycomponentModel>
      exercisetaskstodaycomponentModels;

  @override
  void initState(BuildContext context) {
    incompleteactivitylistModels =
        FlutterFlowDynamicModels(() => IncompleteactivitylistModel());
    exercisetaskstodaycomponentModels =
        FlutterFlowDynamicModels(() => ExercisetaskstodaycomponentModel());
  }

  @override
  void dispose() {
    exerciseWalkthroughController?.finish();
    incompleteactivitylistModels.dispose();
    exercisetaskstodaycomponentModels.dispose();
  }
}
