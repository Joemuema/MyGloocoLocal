import '/backend/backend.dart';
import '/diet/meal_food_item/meal_food_item_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'plate_widget.dart' show PlateWidget;
import 'package:flutter/material.dart';

class PlateModel extends FlutterFlowModel<PlateWidget> {
  ///  Local state fields for this page.

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

  List<double> massList = [];
  void addToMassList(double item) => massList.add(item);
  void removeFromMassList(double item) => massList.remove(item);
  void removeAtIndexFromMassList(int index) => massList.removeAt(index);
  void insertAtIndexInMassList(int index, double item) =>
      massList.insert(index, item);
  void updateMassListAtIndex(int index, Function(double) updateFn) =>
      massList[index] = updateFn(massList[index]);

  double totalKcal = 0.0;

  List<DietRecsRecord> recsList = [];
  void addToRecsList(DietRecsRecord item) => recsList.add(item);
  void removeFromRecsList(DietRecsRecord item) => recsList.remove(item);
  void removeAtIndexFromRecsList(int index) => recsList.removeAt(index);
  void insertAtIndexInRecsList(int index, DietRecsRecord item) =>
      recsList.insert(index, item);
  void updateRecsListAtIndex(int index, Function(DietRecsRecord) updateFn) =>
      recsList[index] = updateFn(recsList[index]);

  String recKey = 'recsKey';

  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? plateWalkthroughController;
  // Stores action output result for [Firestore Query - Query a collection] action in Plate widget.
  List<DietRecsRecord>? recommendations;
  // Stores action output result for [Custom Action - loadRecTableDataLocally] action in Plate widget.
  List<DietRecsRecord>? loadedRecs;
  // Models for mealFoodItem dynamic component.
  late FlutterFlowDynamicModels<MealFoodItemModel> mealFoodItemModels;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<DietRecsRecord>();

  @override
  void initState(BuildContext context) {
    mealFoodItemModels = FlutterFlowDynamicModels(() => MealFoodItemModel());
  }

  @override
  void dispose() {
    plateWalkthroughController?.finish();
    mealFoodItemModels.dispose();
    paginatedDataTableController.dispose();
  }
}
