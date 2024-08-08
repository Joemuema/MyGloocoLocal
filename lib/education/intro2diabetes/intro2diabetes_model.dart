import '/flutter_flow/flutter_flow_util.dart';
import 'intro2diabetes_widget.dart' show Intro2diabetesWidget;
import 'package:flutter/material.dart';

class Intro2diabetesModel extends FlutterFlowModel<Intro2diabetesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
