import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'exercisetaskstodaycomponent_model.dart';
export 'exercisetaskstodaycomponent_model.dart';

class ExercisetaskstodaycomponentWidget extends StatefulWidget {
  const ExercisetaskstodaycomponentWidget({
    super.key,
    required this.taskstodaydocument,
  });

  final AddpagecollectionRecord? taskstodaydocument;

  @override
  State<ExercisetaskstodaycomponentWidget> createState() =>
      _ExercisetaskstodaycomponentWidgetState();
}

class _ExercisetaskstodaycomponentWidgetState
    extends State<ExercisetaskstodaycomponentWidget> {
  late ExercisetaskstodaycomponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExercisetaskstodaycomponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.task_outlined,
                color: Color(0xFF4D7E3E),
                size: 35.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.taskstodaydocument?.activity,
                      'name',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      dateTimeFormat('d/M/y', widget.taskstodaydocument?.date),
                      '0',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
              Theme(
                data: ThemeData(
                  checkboxTheme: CheckboxThemeData(
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  unselectedWidgetColor:
                      FlutterFlowTheme.of(context).secondaryText,
                ),
                child: Checkbox(
                  value: _model.checkboxValue ??= true,
                  onChanged: (newValue) async {
                    setState(() => _model.checkboxValue = newValue!);
                  },
                  side: BorderSide(
                    width: 2,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  activeColor: const Color(0xFF4D7E3E),
                  checkColor: FlutterFlowTheme.of(context).info,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
