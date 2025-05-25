import '/backend/backend.dart';
import '/diet/meal_food_item/meal_food_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'access_from_main_tab_widget.dart' show AccessFromMainTabWidget;
import 'package:flutter/material.dart';

class AccessFromMainTabModel extends FlutterFlowModel<AccessFromMainTabWidget> {
  ///  Local state fields for this component.

  List<FilteredFoodRecord> updatedFoodList = [];
  void addToUpdatedFoodList(FilteredFoodRecord item) =>
      updatedFoodList.add(item);
  void removeFromUpdatedFoodList(FilteredFoodRecord item) =>
      updatedFoodList.remove(item);
  void removeAtIndexFromUpdatedFoodList(int index) =>
      updatedFoodList.removeAt(index);
  void insertAtIndexInUpdatedFoodList(int index, FilteredFoodRecord item) =>
      updatedFoodList.insert(index, item);
  void updateUpdatedFoodListAtIndex(
          int index, Function(FilteredFoodRecord) updateFn) =>
      updatedFoodList[index] = updateFn(updatedFoodList[index]);

  List<double> kcalList = [];
  void addToKcalList(double item) => kcalList.add(item);
  void removeFromKcalList(double item) => kcalList.remove(item);
  void removeAtIndexFromKcalList(int index) => kcalList.removeAt(index);
  void insertAtIndexInKcalList(int index, double item) =>
      kcalList.insert(index, item);
  void updateKcalListAtIndex(int index, Function(double) updateFn) =>
      kcalList[index] = updateFn(kcalList[index]);

  double totalKcal = 0.0;

  List<double> massList = [];
  void addToMassList(double item) => massList.add(item);
  void removeFromMassList(double item) => massList.remove(item);
  void removeAtIndexFromMassList(int index) => massList.removeAt(index);
  void insertAtIndexInMassList(int index, double item) =>
      massList.insert(index, item);
  void updateMassListAtIndex(int index, Function(double) updateFn) =>
      massList[index] = updateFn(massList[index]);

  int mealTime = 0;

  ///  State fields for stateful widgets in this component.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for Foodentrys widget.
  FocusNode? foodentrysFocusNode;
  TextEditingController? foodentrysTextController;
  String? Function(BuildContext, String?)? foodentrysTextControllerValidator;
  String? _foodentrysTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Models for mealFoodItem dynamic component.
  late FlutterFlowDynamicModels<MealFoodItemModel> mealFoodItemModels;

  @override
  void initState(BuildContext context) {
    foodentrysTextControllerValidator = _foodentrysTextControllerValidator;
    mealFoodItemModels = FlutterFlowDynamicModels(() => MealFoodItemModel());
  }

  @override
  void dispose() {
    foodentrysFocusNode?.dispose();
    foodentrysTextController?.dispose();

    mealFoodItemModels.dispose();
  }
}
