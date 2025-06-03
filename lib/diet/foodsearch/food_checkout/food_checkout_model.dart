import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'food_checkout_widget.dart' show FoodCheckoutWidget;
import 'package:flutter/material.dart';

class FoodCheckoutModel extends FlutterFlowModel<FoodCheckoutWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  DateTime? datePicked;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<MealsRecord>? mealDocs;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
