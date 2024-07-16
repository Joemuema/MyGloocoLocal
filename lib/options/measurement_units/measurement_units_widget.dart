import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'measurement_units_model.dart';
export 'measurement_units_model.dart';

class MeasurementUnitsWidget extends StatefulWidget {
  const MeasurementUnitsWidget({super.key});

  @override
  State<MeasurementUnitsWidget> createState() => _MeasurementUnitsWidgetState();
}

class _MeasurementUnitsWidgetState extends State<MeasurementUnitsWidget> {
  late MeasurementUnitsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MeasurementUnitsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550.0,
      height: 361.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 250.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'BG Units',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(60.0, 20.0, 60.0, 20.0),
                  child: FlutterFlowChoiceChips(
                    options: const [ChipData('mg/dl'), ChipData('mmol/L')],
                    onChanged: (val) => setState(
                        () => _model.choiceChipsValue1 = val?.firstOrNull),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                      iconColor: FlutterFlowTheme.of(context).primaryText,
                      iconSize: 18.0,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                      iconSize: 18.0,
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    chipSpacing: 12.0,
                    rowSpacing: 12.0,
                    multiselect: false,
                    alignment: WrapAlignment.center,
                    controller: _model.choiceChipsValueController1 ??=
                        FormFieldController<List<String>>(
                      [],
                    ),
                    wrapped: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 250.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(75.0, 20.0, 75.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-3.0, -1.0),
                    child: Text(
                      'Calories',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  FlutterFlowChoiceChips(
                    options: const [ChipData('kJ'), ChipData('kCal')],
                    onChanged: (val) => setState(
                        () => _model.choiceChipsValue2 = val?.firstOrNull),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                      iconColor: FlutterFlowTheme.of(context).primaryText,
                      iconSize: 18.0,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                      iconSize: 18.0,
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    chipSpacing: 12.0,
                    rowSpacing: 12.0,
                    multiselect: false,
                    alignment: WrapAlignment.center,
                    controller: _model.choiceChipsValueController2 ??=
                        FormFieldController<List<String>>(
                      [],
                    ),
                    wrapped: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
