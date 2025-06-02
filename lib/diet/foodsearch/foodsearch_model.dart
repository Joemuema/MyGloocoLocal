import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'foodsearch_widget.dart' show FoodsearchWidget;
import 'package:flutter/material.dart';

class FoodsearchModel extends FlutterFlowModel<FoodsearchWidget> {
  ///  Local state fields for this page.

  List<FilteredFoodRecord> searchFoodList = [];
  void addToSearchFoodList(FilteredFoodRecord item) => searchFoodList.add(item);
  void removeFromSearchFoodList(FilteredFoodRecord item) =>
      searchFoodList.remove(item);
  void removeAtIndexFromSearchFoodList(int index) =>
      searchFoodList.removeAt(index);
  void insertAtIndexInSearchFoodList(int index, FilteredFoodRecord item) =>
      searchFoodList.insert(index, item);
  void updateSearchFoodListAtIndex(
          int index, Function(FilteredFoodRecord) updateFn) =>
      searchFoodList[index] = updateFn(searchFoodList[index]);

  String? filter;

  List<double> searchKcalList = [];
  void addToSearchKcalList(double item) => searchKcalList.add(item);
  void removeFromSearchKcalList(double item) => searchKcalList.remove(item);
  void removeAtIndexFromSearchKcalList(int index) =>
      searchKcalList.removeAt(index);
  void insertAtIndexInSearchKcalList(int index, double item) =>
      searchKcalList.insert(index, item);
  void updateSearchKcalListAtIndex(int index, Function(double) updateFn) =>
      searchKcalList[index] = updateFn(searchKcalList[index]);

  List<double> searchMassList = [];
  void addToSearchMassList(double item) => searchMassList.add(item);
  void removeFromSearchMassList(double item) => searchMassList.remove(item);
  void removeAtIndexFromSearchMassList(int index) =>
      searchMassList.removeAt(index);
  void insertAtIndexInSearchMassList(int index, double item) =>
      searchMassList.insert(index, item);
  void updateSearchMassListAtIndex(int index, Function(double) updateFn) =>
      searchMassList[index] = updateFn(searchMassList[index]);

  String foodKey = 'foodKey';

  List<FilteredFoodRecord> foodSearchResults = [];
  void addToFoodSearchResults(FilteredFoodRecord item) =>
      foodSearchResults.add(item);
  void removeFromFoodSearchResults(FilteredFoodRecord item) =>
      foodSearchResults.remove(item);
  void removeAtIndexFromFoodSearchResults(int index) =>
      foodSearchResults.removeAt(index);
  void insertAtIndexInFoodSearchResults(int index, FilteredFoodRecord item) =>
      foodSearchResults.insert(index, item);
  void updateFoodSearchResultsAtIndex(
          int index, Function(FilteredFoodRecord) updateFn) =>
      foodSearchResults[index] = updateFn(foodSearchResults[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Foodsearch widget.
  List<FilteredFoodRecord>? allFoodItems;
  // Stores action output result for [Custom Action - loadFoodSearchDataLocally] action in Foodsearch widget.
  List<FilteredFoodRecord>? foodSearchOutput;
  // State field(s) for Searchbar widget.
  FocusNode? searchbarFocusNode;
  TextEditingController? searchbarTextController;
  String? Function(BuildContext, String?)? searchbarTextControllerValidator;
  List<FilteredFoodRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchbarFocusNode?.dispose();
    searchbarTextController?.dispose();
  }
}
