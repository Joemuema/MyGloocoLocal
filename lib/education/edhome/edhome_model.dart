import '/flutter_flow/flutter_flow_util.dart';
import 'edhome_widget.dart' show EdhomeWidget;
import 'package:flutter/material.dart';

class EdhomeModel extends FlutterFlowModel<EdhomeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
