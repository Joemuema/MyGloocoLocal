import '/flutter_flow/flutter_flow_util.dart';
import 'recipe_list_widget.dart' show RecipeListWidget;
import 'package:flutter/material.dart';

class RecipeListModel extends FlutterFlowModel<RecipeListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
