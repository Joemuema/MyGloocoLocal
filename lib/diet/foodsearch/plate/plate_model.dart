import '/backend/backend.dart';
import '/diet/foodsearch/food_checkout/food_checkout_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'plate_widget.dart' show PlateWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlateModel extends FlutterFlowModel<PlateWidget> {
  ///  Local state fields for this page.

  List<FoodRecord> updatedFoodList = [];
  void addToUpdatedFoodList(FoodRecord item) => updatedFoodList.add(item);
  void removeFromUpdatedFoodList(FoodRecord item) =>
      updatedFoodList.remove(item);
  void removeAtIndexFromUpdatedFoodList(int index) =>
      updatedFoodList.removeAt(index);
  void insertAtIndexInUpdatedFoodList(int index, FoodRecord item) =>
      updatedFoodList.insert(index, item);
  void updateUpdatedFoodListAtIndex(int index, Function(FoodRecord) updateFn) =>
      updatedFoodList[index] = updateFn(updatedFoodList[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
