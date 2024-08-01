import '/backend/backend.dart';
import '/exercises/exercisetaskstodaycomponent/exercisetaskstodaycomponent_widget.dart';
import '/exercises/incompleteactivitylist/incompleteactivitylist_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/logs/addactivity/addactivity_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'exercisehomepage_widget.dart' show ExercisehomepageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
