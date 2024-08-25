import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'final_foodlist_model.dart';
export 'final_foodlist_model.dart';

class FinalFoodlistWidget extends StatefulWidget {
  const FinalFoodlistWidget({
    super.key,
    this.parameter1,
    this.parameter2,
  });

  final String? parameter1;
  final double? parameter2;

  @override
  State<FinalFoodlistWidget> createState() => _FinalFoodlistWidgetState();
}

class _FinalFoodlistWidgetState extends State<FinalFoodlistWidget> {
  late FinalFoodlistModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinalFoodlistModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
          child: Text(
            widget.parameter1!,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 17.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ],
    );
  }
}
