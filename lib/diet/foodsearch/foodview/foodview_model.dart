import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'foodview_widget.dart' show FoodviewWidget;
import 'package:flutter/material.dart';

class FoodviewModel extends FlutterFlowModel<FoodviewWidget> {
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
