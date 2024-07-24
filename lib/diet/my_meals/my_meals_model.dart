import '/flutter_flow/flutter_flow_util.dart';
import 'my_meals_widget.dart' show MyMealsWidget;
import 'package:flutter/material.dart';

class MyMealsModel extends FlutterFlowModel<MyMealsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
