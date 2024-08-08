import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'foodsearch_widget.dart' show FoodsearchWidget;
import 'package:flutter/material.dart';

class FoodsearchModel extends FlutterFlowModel<FoodsearchWidget> {
  ///  Local state fields for this page.

  List<FoodRecord> searchFoodList = [];
  void addToSearchFoodList(FoodRecord item) => searchFoodList.add(item);
  void removeFromSearchFoodList(FoodRecord item) => searchFoodList.remove(item);
  void removeAtIndexFromSearchFoodList(int index) =>
      searchFoodList.removeAt(index);
  void insertAtIndexInSearchFoodList(int index, FoodRecord item) =>
      searchFoodList.insert(index, item);
  void updateSearchFoodListAtIndex(int index, Function(FoodRecord) updateFn) =>
      searchFoodList[index] = updateFn(searchFoodList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for Searchbar widget.
  FocusNode? searchbarFocusNode;
  TextEditingController? searchbarTextController;
  String? Function(BuildContext, String?)? searchbarTextControllerValidator;
  List<FoodRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchbarFocusNode?.dispose();
    searchbarTextController?.dispose();
  }
}
