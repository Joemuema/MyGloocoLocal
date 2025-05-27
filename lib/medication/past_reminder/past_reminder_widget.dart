import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'past_reminder_model.dart';
export 'past_reminder_model.dart';

class PastReminderWidget extends StatefulWidget {
  const PastReminderWidget({
    super.key,
    required this.reminderRef,
  });

  final DocumentReference? reminderRef;

  @override
  State<PastReminderWidget> createState() => _PastReminderWidgetState();
}

class _PastReminderWidgetState extends State<PastReminderWidget> {
  late PastReminderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PastReminderModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
      child: StreamBuilder<RemindersRecord>(
        stream: RemindersRecord.getDocument(widget.reminderRef!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }

          final containerRemindersRecord = snapshot.data!;

          return Container(
            width: 382.0,
            height: 77.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder<MedicineRecord>(
              stream: MedicineRecord.getDocument(
                  containerRemindersRecord.medicineID!),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }

                final rowMedicineRecord = snapshot.data!;

                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            if (rowMedicineRecord.form == 'Pill' ? true : false)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Icon(
                                  FFIcons.kdrug,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 43.0,
                                ),
                              ),
                            if (rowMedicineRecord.form == 'Tablet'
                                ? true
                                : false)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Icon(
                                  FFIcons.kmedicine,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 43.0,
                                ),
                              ),
                            if (rowMedicineRecord.form == 'Emulsion'
                                ? true
                                : false)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Icon(
                                  FFIcons.ksyrup,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 43.0,
                                ),
                              ),
                            if (rowMedicineRecord.form == 'Injection'
                                ? true
                                : false)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Icon(
                                  FFIcons.kinjection,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 43.0,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                rowMedicineRecord.name,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Form: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                rowMedicineRecord.form,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Dose: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                '${(rowMedicineRecord.form == 'Pill') && (rowMedicineRecord.form == 'Tablet') ? formatNumber(
                                    rowMedicineRecord.singleDose,
                                    formatType: FormatType.custom,
                                    format: '0',
                                    locale: 'en_US',
                                  ) : formatNumber(
                                    rowMedicineRecord.singleDose,
                                    formatType: FormatType.custom,
                                    format: '.0',
                                    locale: 'en_US',
                                  )} ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                () {
                                  if (rowMedicineRecord.form == 'Pill') {
                                    return (formatNumber(
                                              rowMedicineRecord.singleDose,
                                              formatType: FormatType.custom,
                                              format: '0',
                                              locale: 'en_US',
                                            ) ==
                                            '1'
                                        ? 'capsule'
                                        : 'capsules');
                                  } else if (rowMedicineRecord.form ==
                                      'Tablet') {
                                    return (formatNumber(
                                              rowMedicineRecord.singleDose,
                                              formatType: FormatType.custom,
                                              format: '0',
                                              locale: 'en_US',
                                            ) ==
                                            '1'
                                        ? 'tablet'
                                        : 'tablets');
                                  } else if (rowMedicineRecord.form ==
                                      'Emulsion') {
                                    return 'ml (${formatNumber(
                                      rowMedicineRecord.singleDose / 15,
                                      formatType: FormatType.custom,
                                      format: '0.0',
                                      locale: 'en_US',
                                    )} tablespoons)';
                                  } else {
                                    return (formatNumber(
                                              rowMedicineRecord.singleDose,
                                              formatType: FormatType.custom,
                                              format: '0',
                                              locale: 'en_US',
                                            ) ==
                                            '1'
                                        ? 'unit'
                                        : 'units');
                                  }
                                }(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
