import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: FlutterFlowTheme.of(context).boxShadowColor,
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.task_outlined,
                color: FlutterFlowTheme.of(context).primary,
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
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      dateTimeFormat("d/M/y", widget.taskstodaydocument?.date),
                      '0',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                    safeSetState(() => _model.checkboxValue = newValue!);
                  },
                  side: (FlutterFlowTheme.of(context).secondaryText != null)
                      ? BorderSide(
                          width: 2,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        )
                      : null,
                  activeColor: FlutterFlowTheme.of(context).primary,
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
