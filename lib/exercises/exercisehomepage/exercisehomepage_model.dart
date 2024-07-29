import '/exercises/exercisetaskstodaycomponent/exercisetaskstodaycomponent_widget.dart';
import '/exercises/incompleteactivitylist/incompleteactivitylist_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'exercisehomepage_widget.dart' show ExercisehomepageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExercisehomepageModel extends FlutterFlowModel<ExercisehomepageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Carousel widget.
  CarouselController? carouselController;
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
    unfocusNode.dispose();
    incompleteactivitylistModels.dispose();
    exercisetaskstodaycomponentModels.dispose();
  }
}
