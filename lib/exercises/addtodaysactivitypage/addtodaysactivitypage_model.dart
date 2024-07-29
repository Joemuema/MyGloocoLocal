import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/logs/addactivity/addactivity_widget.dart';
import 'addtodaysactivitypage_widget.dart' show AddtodaysactivitypageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddtodaysactivitypageModel
    extends FlutterFlowModel<AddtodaysactivitypageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for addactivity component.
  late AddactivityModel addactivityModel;

  @override
  void initState(BuildContext context) {
    addactivityModel = createModel(context, () => AddactivityModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    addactivityModel.dispose();
  }
}
