import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/logs/addactivity/addactivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'addtodaysactivitypage_model.dart';
export 'addtodaysactivitypage_model.dart';

class AddtodaysactivitypageWidget extends StatefulWidget {
  const AddtodaysactivitypageWidget({super.key});

  @override
  State<AddtodaysactivitypageWidget> createState() =>
      _AddtodaysactivitypageWidgetState();
}

class _AddtodaysactivitypageWidgetState
    extends State<AddtodaysactivitypageWidget> {
  late AddtodaysactivitypageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddtodaysactivitypageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: wrapWithModel(
          model: _model.addactivityModel,
          updateCallback: () => setState(() {}),
          child: AddactivityWidget(),
        ),
      ),
    );
  }
}
