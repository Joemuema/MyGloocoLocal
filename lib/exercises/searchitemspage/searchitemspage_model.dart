import '/backend/backend.dart';
import '/exercises/searchpageitemscomponent/searchpageitemscomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'searchitemspage_widget.dart' show SearchitemspageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class SearchitemspageModel extends FlutterFlowModel<SearchitemspageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<AddpagecollectionRecord> simpleSearchResults1 = [];
  List<AddpagecollectionRecord> simpleSearchResults2 = [];
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
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    searchpageitemscomponentModels1.dispose();
    searchpageitemscomponentModels2.dispose();
  }
}
