import '/backend/backend.dart';
import '/exercises/searchpageitemscomponent/searchpageitemscomponent_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'searchitemspage_widget.dart' show SearchitemspageWidget;
import 'package:flutter/material.dart';

class SearchitemspageModel extends FlutterFlowModel<SearchitemspageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<AddpagecollectionRecord> simpleSearchResults = [];
  // Models for searchpageitemscomponent dynamic component.
  late FlutterFlowDynamicModels<SearchpageitemscomponentModel>
      searchpageitemscomponentModels1;
  // Models for searchpageitemscomponent dynamic component.
  late FlutterFlowDynamicModels<SearchpageitemscomponentModel>
      searchpageitemscomponentModels2;

  @override
  void initState(BuildContext context) {
    searchpageitemscomponentModels1 =
        FlutterFlowDynamicModels(() => SearchpageitemscomponentModel());
    searchpageitemscomponentModels2 =
        FlutterFlowDynamicModels(() => SearchpageitemscomponentModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    searchpageitemscomponentModels1.dispose();
    searchpageitemscomponentModels2.dispose();
  }
}
