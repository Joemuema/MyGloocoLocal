import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'home_reminder_model.dart';
export 'home_reminder_model.dart';

class HomeReminderWidget extends StatefulWidget {
  const HomeReminderWidget({
    super.key,
    required this.medicineReminder,
  });

  final DocumentReference? medicineReminder;

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
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
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
              boxShadow: const [
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
            child: Row(
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 15.0),
                            child: Icon(
                              FFIcons.kdrug,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 43.0,
                            ),
                          ),
                        if (containerMedicineRecord.form == 'Tablet'
                            ? true
                            : false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 15.0),
                            child: Icon(
                              FFIcons.kmedicine,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 43.0,
                            ),
                          ),
                        if (containerMedicineRecord.form == 'Emulsion'
                            ? true
                            : false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 15.0),
                            child: Icon(
                              FFIcons.ksyrup,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 43.0,
                            ),
                          ),
                        if (containerMedicineRecord.form == 'Injection'
                            ? true
                            : false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 15.0),
                            child: Icon(
                              FFIcons.kinjection,
                              color: FlutterFlowTheme.of(context).secondaryText,
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
                                  fontFamily: 'Readex Pro',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
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
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Text(
                            containerMedicineRecord.form,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
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
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Text(
                            '${containerMedicineRecord.singleDose.toString()} ',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Text(
                            () {
                              if (containerMedicineRecord.form == 'Pill') {
                                return (containerMedicineRecord.singleDose ==
                                        1.0
                                    ? 'capsule'
                                    : 'capsules');
                              } else if (containerMedicineRecord.form ==
                                  'Tablet') {
                                return (containerMedicineRecord.singleDose ==
                                        1.0
                                    ? 'tablet'
                                    : 'tablets');
                              } else if (containerMedicineRecord.form ==
                                  'Emulsion') {
                                return (containerMedicineRecord.singleDose ==
                                        1.0
                                    ? 'tablespoons'
                                    : 'tablespoons');
                              } else {
                                return (containerMedicineRecord.singleDose ==
                                        1.0
                                    ? 'unit'
                                    : 'units');
                              }
                            }(),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Switch.adaptive(
                          value: _model.switchValue ??=
                              containerMedicineRecord.setReminders,
                          onChanged: (newValue) async {
                            setState(() => _model.switchValue = newValue);

                            if (!newValue) {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Turn Off?'),
                                            content: const Text(
                                                'Are you sure you want to turn off this reminder? It will automatically be marked as missed if you do.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
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
            ),
          );
        },
      ),
    );
  }
}
