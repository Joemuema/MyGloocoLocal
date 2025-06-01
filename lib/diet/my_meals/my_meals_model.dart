import '/diet/recipes/empty_meal_plan/empty_meal_plan_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_meals_widget.dart' show MyMealsWidget;
import 'package:flutter/material.dart';

class MyMealsModel extends FlutterFlowModel<MyMealsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for emptyMealPlan component.
  late EmptyMealPlanModel emptyMealPlanModel;

  @override
  void initState(BuildContext context) {
    emptyMealPlanModel = createModel(context, () => EmptyMealPlanModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    emptyMealPlanModel.dispose();
  }
}
