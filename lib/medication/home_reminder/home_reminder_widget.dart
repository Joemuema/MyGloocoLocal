import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_reminder_model.dart';
export 'home_reminder_model.dart';

class HomeReminderWidget extends StatefulWidget {
  const HomeReminderWidget({
    super.key,
    required this.medicineReminder,
    required this.reminderID,
  });

  final DocumentReference? medicineReminder;
  final DocumentReference? reminderID;

  @override
  State<HomeReminderWidget> createState() => _HomeReminderWidgetState();
}

class _HomeReminderWidgetState extends State<HomeReminderWidget> {
  late HomeReminderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeReminderModel());

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
      child: StreamBuilder<MedicineRecord>(
        stream: MedicineRecord.getDocument(widget.medicineReminder!),
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

          final containerMedicineRecord = snapshot.data!;

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
            child: StreamBuilder<RemindersRecord>(
              stream: RemindersRecord.getDocument(widget.reminderID!),
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

                final rowRemindersRecord = snapshot.data!;

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
                            if (containerMedicineRecord.form == 'Pill'
                                ? true
                                : false)
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
                            if (containerMedicineRecord.form == 'Tablet'
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
                            if (containerMedicineRecord.form == 'Emulsion'
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
                            if (containerMedicineRecord.form == 'Injection'
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
                                containerMedicineRecord.name,
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
                                containerMedicineRecord.form,
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
                                '${containerMedicineRecord.singleDose.toString()} ',
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
                                  if (containerMedicineRecord.form == 'Pill') {
                                    return (containerMedicineRecord
                                                .singleDose ==
                                            1.0
                                        ? 'capsule'
                                        : 'capsules');
                                  } else if (containerMedicineRecord.form ==
                                      'Tablet') {
                                    return (containerMedicineRecord
                                                .singleDose ==
                                            1.0
                                        ? 'tablet'
                                        : 'tablets');
                                  } else if (containerMedicineRecord.form ==
                                      'Emulsion') {
                                    return 'ml (${formatNumber(
                                      containerMedicineRecord.singleDose / 15,
                                      formatType: FormatType.custom,
                                      format: '0.0',
                                      locale: 'en_US',
                                    )} tablespoons)';
                                  } else {
                                    return (containerMedicineRecord
                                                .singleDose ==
                                            1.0
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Switch.adaptive(
                              value: _model.switchValue ??=
                                  containerMedicineRecord.setReminders,
                              onChanged: (newValue) async {
                                safeSetState(
                                    () => _model.switchValue = newValue);
                                if (newValue) {
                                  _model.specificReminderOn =
                                      await queryIndividualRemindersRecordOnce(
                                    parent: widget.reminderID,
                                    queryBuilder: (individualRemindersRecord) =>
                                        individualRemindersRecord
                                            .where(
                                              'Date',
                                              isEqualTo: valueOrDefault<String>(
                                                functions.getDate(
                                                    getCurrentTimestamp),
                                                'today',
                                              ),
                                            )
                                            .where(
                                              'Time',
                                              isEqualTo:
                                                  rowRemindersRecord.time,
                                            ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);

                                  await _model.specificReminderOn!.reference
                                      .update(
                                          createIndividualRemindersRecordData(
                                    isActive: true,
                                  ));
                                  await actions.reactivateNotification(
                                    _model.specificReminderOn!.notificationID,
                                    _model.specificReminderOn!.parentReference,
                                    _model.specificReminderOn!.date,
                                    _model.specificReminderOn!.time,
                                    _model.specificReminderOn!.title,
                                    _model.specificReminderOn!.content,
                                  );

                                  safeSetState(() {});
                                } else {
                                  var confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Turn Off?'),
                                                content: Text(
                                                    'Are you sure you want to turn off this reminder? It will not be triggered at the scheduled time but and will be marked as missed by default.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false;
                                  _model.specificReminderOff =
                                      await queryIndividualRemindersRecordOnce(
                                    parent: widget.reminderID,
                                    queryBuilder: (individualRemindersRecord) =>
                                        individualRemindersRecord
                                            .where(
                                              'Date',
                                              isEqualTo: valueOrDefault<String>(
                                                functions.getDate(
                                                    getCurrentTimestamp),
                                                'today',
                                              ),
                                            )
                                            .where(
                                              'Time',
                                              isEqualTo:
                                                  rowRemindersRecord.time,
                                            ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);

                                  await _model.specificReminderOff!.reference
                                      .update(
                                          createIndividualRemindersRecordData(
                                    isActive: false,
                                  ));
                                  await actions.cancelNotification(
                                    _model.specificReminderOff!.notificationID,
                                  );

                                  safeSetState(() {});
                                }
                              },
                              activeColor: FlutterFlowTheme.of(context).primary,
                              activeTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveTrackColor:
                                  FlutterFlowTheme.of(context).alternate,
                              inactiveThumbColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        ),
                      ],
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
