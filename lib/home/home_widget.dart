import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/chart_settings_widget.dart';
import '/diet/access_from_main_tab/access_from_main_tab_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/logs/addactivity/addactivity_widget.dart';
import '/logs/bglogs/bglogs_widget.dart';
import '/walkthroughs/home_page_walkthrough.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
    this.chartDate,
    String? setChartType,
    String? setChartUnits,
    String? setInterval,
  })  : this.setChartType = setChartType ?? 'single',
        this.setChartUnits = setChartUnits ?? 'mgdl',
        this.setInterval = setInterval ?? 'daily';

  final DateTime? chartDate;
  final String setChartType;
  final String setChartUnits;
  final String setInterval;

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().homeTutorial == false) {
        safeSetState(() => _model.homePageWalkthroughController =
            createPageWalkthrough(context));
        _model.homePageWalkthroughController?.show(context: context);
        FFAppState().homeTutorial = true;
        safeSetState(() {});
      }
      _model.currentChartDate =
          widget.chartDate != null ? widget.chartDate : getCurrentTimestamp;
      safeSetState(() {});
      if (widget.setInterval == 'daily') {
        _model.todayReadings = await queryBGreadingsRecordOnce(
          queryBuilder: (bGreadingsRecord) => bGreadingsRecord
              .where(
                'UserID',
                isEqualTo: FFAppState().UserID,
              )
              .where(
                'Date',
                isEqualTo: functions.getDate(_model.currentChartDate!),
              )
              .orderBy('Time'),
        );
        _model.bloodSugarAvg = valueOrDefault<double>(
          functions.avgSugarReadings(
              _model.todayReadings!.map((e) => e.cGMreading).toList().toList()),
          0.0,
        );
        _model.dayReadings =
            _model.todayReadings!.toList().cast<BGreadingsRecord>();
        safeSetState(() {});
      } else {
        if (widget.setInterval == 'weekly') {
          if (_model.currentChartDate! >=
              functions.firstDayOfWeek(getCurrentTimestamp)) {
            if (functions.currentDate(_model.currentChartDate!) <=
                functions.currentDate(getCurrentTimestamp)) {
              _model.thisWeekReadings = await queryBGreadingsRecordOnce(
                queryBuilder: (bGreadingsRecord) => bGreadingsRecord
                    .where(
                      'UserID',
                      isEqualTo: FFAppState().UserID,
                    )
                    .where(
                      'Date',
                      isGreaterThanOrEqualTo: valueOrDefault<String>(
                        functions.getDate(
                            functions.firstDayOfWeek(getCurrentTimestamp)),
                        '01-01-2025',
                      ),
                    )
                    .orderBy('Date')
                    .orderBy('Time'),
              );
              _model.bloodSugarAvg = valueOrDefault<double>(
                functions.avgSugarReadings(_model.thisWeekReadings!
                    .map((e) => valueOrDefault<double>(
                          e.cGMreading,
                          0.0,
                        ))
                    .toList()
                    .toList()),
                0.0,
              );
              _model.weekReadings =
                  _model.thisWeekReadings!.toList().cast<BGreadingsRecord>();
              safeSetState(() {});
            } else {
              _model.weekReadings = [];
              safeSetState(() {});
            }
          } else {
            _model.pastWeekReadings = await queryBGreadingsRecordOnce(
              queryBuilder: (bGreadingsRecord) => bGreadingsRecord
                  .where(
                    'UserID',
                    isEqualTo: FFAppState().UserID,
                  )
                  .where(
                    'Date',
                    isGreaterThanOrEqualTo: valueOrDefault<String>(
                      functions.getDate(
                          functions.firstDayOfWeek(_model.currentChartDate!)),
                      '01-01-2025',
                    ),
                  )
                  .where(
                    'Date',
                    isLessThan: valueOrDefault<String>(
                      functions.getDate(functions.firstDayOfWeek(
                          functions.incrementWeek(_model.currentChartDate!))),
                      '01-01-2025',
                    ),
                  )
                  .orderBy('Date')
                  .orderBy('Time'),
            );
            _model.bloodSugarAvg = valueOrDefault<double>(
              functions.avgSugarReadings(_model.pastWeekReadings!
                  .map((e) => e.cGMreading)
                  .toList()
                  .toList()),
              0.0,
            );
            _model.weekReadings =
                _model.pastWeekReadings!.toList().cast<BGreadingsRecord>();
            safeSetState(() {});
          }
        } else {
          if (_model.currentChartDate! >=
              functions.firstDayOfMonth(getCurrentTimestamp)) {
            if (functions.currentDate(_model.currentChartDate!) <=
                functions.currentDate(getCurrentTimestamp)) {
              _model.thisMonthReadings = await queryBGreadingsRecordOnce(
                queryBuilder: (bGreadingsRecord) => bGreadingsRecord
                    .where(
                      'UserID',
                      isEqualTo: FFAppState().UserID,
                    )
                    .where(
                      'Date',
                      isGreaterThanOrEqualTo: valueOrDefault<String>(
                        functions.getDate(
                            functions.firstDayOfMonth(getCurrentTimestamp)),
                        '01-01-2025',
                      ),
                    )
                    .orderBy('Date')
                    .orderBy('Time'),
              );
              _model.bloodSugarAvg = valueOrDefault<double>(
                functions.avgSugarReadings(_model.thisMonthReadings!
                    .map((e) => e.cGMreading)
                    .toList()
                    .toList()),
                0.0,
              );
              _model.monthReadings =
                  _model.thisMonthReadings!.toList().cast<BGreadingsRecord>();
              safeSetState(() {});
            } else {
              _model.monthReadings = [];
              safeSetState(() {});
            }
          } else {
            _model.pastMonthReadings = await queryBGreadingsRecordOnce(
              queryBuilder: (bGreadingsRecord) => bGreadingsRecord
                  .where(
                    'UserID',
                    isEqualTo: FFAppState().UserID,
                  )
                  .where(
                    'Date',
                    isGreaterThanOrEqualTo: valueOrDefault<String>(
                      functions.getDate(
                          functions.firstDayOfMonth(_model.currentChartDate!)),
                      '01-01-2025',
                    ),
                  )
                  .where(
                    'Date',
                    isLessThan: valueOrDefault<String>(
                      functions.getDate(functions.firstDayOfMonth(
                          functions.incrementMonth(_model.currentChartDate!))),
                      '01-01-2025',
                    ),
                  )
                  .orderBy('Date')
                  .orderBy('Time'),
            );
            _model.bloodSugarAvg = valueOrDefault<double>(
              functions.avgSugarReadings(_model.pastMonthReadings!
                  .map((e) => e.cGMreading)
                  .toList()
                  .toList()),
              0.0,
            );
            _model.monthReadings =
                _model.pastMonthReadings!.toList().cast<BGreadingsRecord>();
            safeSetState(() {});
          }
        }
      }

      if (FFAppState().medicineRemindersUpdated == false) {
        _model.unmarkedReminders = await queryIndividualRemindersRecordOnce(
          queryBuilder: (individualRemindersRecord) => individualRemindersRecord
              .where(
                'UserID',
                isEqualTo: FFAppState().UserID,
              )
              .where(
                'Status',
                isEqualTo: 'Unset',
              )
              .orderBy('Date'),
        );
        await actions.updateMissedReminders(
          functions
              .combineIndividualReminders(
                  _model.unmarkedReminders!
                      .where((e) =>
                          (functions.stringToDate(e.date) >=
                              FFAppState().lastUpdatedReminders!) &&
                          (functions.stringToDate(e.date) <
                              functions.currentDate(getCurrentTimestamp)))
                      .toList()
                      .toList(),
                  _model.unmarkedReminders!
                      .where((e) =>
                          (functions.stringToDate(e.date) ==
                              functions.currentDate(getCurrentTimestamp)) &&
                          (functions.todayTime(e.time) <
                              functions.currentTimeXHoursBack(
                                  getCurrentTimestamp, 1.0)))
                      .toList()
                      .toList())
              .toList(),
        );
        FFAppState().medicineRemindersUpdated = true;
        FFAppState().lastUpdatedReminders = getCurrentTimestamp;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) => Text(
                              'Hi, ${valueOrDefault<String>(
                                currentUserDisplayName,
                                'User',
                              )}!',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Text(
                            dateTimeFormat("E, d MMMM", getCurrentTimestamp),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 10.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: FlutterFlowTheme.of(context).primary,
                              borderRadius: 20.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.person,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.pushNamed(SettingsWidget.routeName);
                              },
                            ).addWalkthrough(
                              iconButtonGzliz8gr,
                              _model.homePageWalkthroughController,
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: ChartSettingsWidget(
                                                chartType: widget.setChartType,
                                                unitsUsed:
                                                    widget.setChartUnits,
                                                chartInterval:
                                                    widget.setInterval,
                                                chartDate:
                                                    _model.currentChartDate,
                                                rebuild: () async {
                                                  _model.currentChartDate = () {
                                                    if (widget.setInterval ==
                                                        'daily') {
                                                      return functions
                                                          .incrementDate(_model
                                                              .currentChartDate!);
                                                    } else if (widget
                                                            .setInterval ==
                                                        'weekly') {
                                                      return functions
                                                          .incrementWeek(_model
                                                              .currentChartDate!);
                                                    } else {
                                                      return functions
                                                          .incrementMonth(_model
                                                              .currentChartDate!);
                                                    }
                                                  }();
                                                  safeSetState(() {});
                                                  _model.currentChartDate = () {
                                                    if (widget.setInterval ==
                                                        'daily') {
                                                      return functions
                                                          .decrementDate(_model
                                                              .currentChartDate!);
                                                    } else if (widget
                                                            .setInterval ==
                                                        'weekly') {
                                                      return functions
                                                          .decrementWeek(_model
                                                              .currentChartDate!);
                                                    } else {
                                                      return functions
                                                          .decrementMonth(_model
                                                              .currentChartDate!);
                                                    }
                                                  }();
                                                  safeSetState(() {});
                                                  if (widget.setInterval ==
                                                      'daily') {
                                                    _model.refreshDayReadings =
                                                        await queryBGreadingsRecordOnce(
                                                      queryBuilder:
                                                          (bGreadingsRecord) =>
                                                              bGreadingsRecord
                                                                  .where(
                                                                    'UserID',
                                                                    isEqualTo:
                                                                        FFAppState()
                                                                            .UserID,
                                                                  )
                                                                  .where(
                                                                    'Date',
                                                                    isEqualTo: functions
                                                                        .getDate(
                                                                            _model.currentChartDate!),
                                                                  )
                                                                  .orderBy(
                                                                      'Time'),
                                                    );
                                                    _model.bloodSugarAvg =
                                                        valueOrDefault<double>(
                                                      functions.avgSugarReadings(
                                                          _model
                                                              .refreshDayReadings!
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList()),
                                                      0.0,
                                                    );
                                                    _model.dayReadings = _model
                                                        .refreshDayReadings!
                                                        .toList()
                                                        .cast<
                                                            BGreadingsRecord>();
                                                    safeSetState(() {});
                                                  } else {
                                                    if (widget.setInterval ==
                                                        'weekly') {
                                                      if (_model
                                                              .currentChartDate! >=
                                                          functions.firstDayOfWeek(
                                                              getCurrentTimestamp)) {
                                                        if (functions.currentDate(
                                                                _model
                                                                    .currentChartDate!) <=
                                                            functions.currentDate(
                                                                getCurrentTimestamp)) {
                                                          _model.refreshWeekReadings =
                                                              await queryBGreadingsRecordOnce(
                                                            queryBuilder: (bGreadingsRecord) =>
                                                                bGreadingsRecord
                                                                    .where(
                                                                      'UserID',
                                                                      isEqualTo:
                                                                          FFAppState()
                                                                              .UserID,
                                                                    )
                                                                    .where(
                                                                      'Date',
                                                                      isGreaterThanOrEqualTo:
                                                                          functions
                                                                              .getDate(functions.firstDayOfWeek(getCurrentTimestamp)),
                                                                    )
                                                                    .orderBy(
                                                                        'Date')
                                                                    .orderBy(
                                                                        'Time'),
                                                          );
                                                          _model.bloodSugarAvg =
                                                              valueOrDefault<
                                                                  double>(
                                                            functions.avgSugarReadings(_model
                                                                .refreshWeekReadings!
                                                                .map((e) => e
                                                                    .cGMreading)
                                                                .toList()),
                                                            0.0,
                                                          );
                                                          _model.weekReadings = _model
                                                              .refreshWeekReadings!
                                                              .toList()
                                                              .cast<
                                                                  BGreadingsRecord>();
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.weekReadings =
                                                              [];
                                                          safeSetState(() {});
                                                        }
                                                      } else {
                                                        _model.refreshFullWeekReadings =
                                                            await queryBGreadingsRecordOnce(
                                                          queryBuilder:
                                                              (bGreadingsRecord) =>
                                                                  bGreadingsRecord
                                                                      .where(
                                                                        'UserID',
                                                                        isEqualTo:
                                                                            FFAppState().UserID,
                                                                      )
                                                                      .where(
                                                                        'Date',
                                                                        isGreaterThanOrEqualTo:
                                                                            functions.getDate(functions.firstDayOfWeek(_model.currentChartDate!)),
                                                                      )
                                                                      .where(
                                                                        'Date',
                                                                        isLessThan:
                                                                            functions.getDate(functions.firstDayOfWeek(functions.incrementWeek(_model.currentChartDate!))),
                                                                      )
                                                                      .orderBy(
                                                                          'Date')
                                                                      .orderBy(
                                                                          'Time'),
                                                        );
                                                        _model.bloodSugarAvg =
                                                            valueOrDefault<
                                                                double>(
                                                          functions.avgSugarReadings(_model
                                                              .refreshFullWeekReadings!
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList()),
                                                          0.0,
                                                        );
                                                        _model.weekReadings = _model
                                                            .refreshFullWeekReadings!
                                                            .toList()
                                                            .cast<
                                                                BGreadingsRecord>();
                                                        safeSetState(() {});
                                                      }
                                                    } else {
                                                      if (_model
                                                              .currentChartDate! >=
                                                          functions.firstDayOfMonth(
                                                              getCurrentTimestamp)) {
                                                        if (functions.currentDate(
                                                                _model
                                                                    .currentChartDate!) <=
                                                            functions.currentDate(
                                                                getCurrentTimestamp)) {
                                                          _model.refreshMonthReadings =
                                                              await queryBGreadingsRecordOnce(
                                                            queryBuilder: (bGreadingsRecord) =>
                                                                bGreadingsRecord
                                                                    .where(
                                                                      'UserID',
                                                                      isEqualTo:
                                                                          FFAppState()
                                                                              .UserID,
                                                                    )
                                                                    .where(
                                                                      'Date',
                                                                      isGreaterThanOrEqualTo:
                                                                          functions
                                                                              .getDate(functions.firstDayOfMonth(getCurrentTimestamp)),
                                                                    )
                                                                    .orderBy(
                                                                        'Date')
                                                                    .orderBy(
                                                                        'Time'),
                                                          );
                                                          _model.bloodSugarAvg =
                                                              valueOrDefault<
                                                                  double>(
                                                            functions.avgSugarReadings(_model
                                                                .refreshMonthReadings!
                                                                .map((e) => e
                                                                    .cGMreading)
                                                                .toList()),
                                                            0.0,
                                                          );
                                                          _model.monthReadings = _model
                                                              .refreshMonthReadings!
                                                              .toList()
                                                              .cast<
                                                                  BGreadingsRecord>();
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.monthReadings =
                                                              [];
                                                          safeSetState(() {});
                                                        }
                                                      } else {
                                                        _model.refreshFullMonthReadings =
                                                            await queryBGreadingsRecordOnce(
                                                          queryBuilder:
                                                              (bGreadingsRecord) =>
                                                                  bGreadingsRecord
                                                                      .where(
                                                                        'UserID',
                                                                        isEqualTo:
                                                                            FFAppState().UserID,
                                                                      )
                                                                      .where(
                                                                        'Date',
                                                                        isGreaterThanOrEqualTo:
                                                                            functions.getDate(functions.firstDayOfMonth(_model.currentChartDate!)),
                                                                      )
                                                                      .where(
                                                                        'Date',
                                                                        isLessThan:
                                                                            functions.getDate(functions.firstDayOfMonth(functions.incrementMonth(_model.currentChartDate!))),
                                                                      )
                                                                      .orderBy(
                                                                          'Date')
                                                                      .orderBy(
                                                                          'Time'),
                                                        );
                                                        _model.bloodSugarAvg =
                                                            valueOrDefault<
                                                                double>(
                                                          functions.avgSugarReadings(_model
                                                              .refreshFullMonthReadings!
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList()),
                                                          0.0,
                                                        );
                                                        _model.monthReadings = _model
                                                            .refreshFullMonthReadings!
                                                            .toList()
                                                            .cast<
                                                                BGreadingsRecord>();
                                                        safeSetState(() {});
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));

                                      safeSetState(() {});
                                    },
                                    text: 'BG Chart',
                                    icon: Icon(
                                      Icons.settings_rounded,
                                      size: 15.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 34.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconAlignment: IconAlignment.end,
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ).addWalkthrough(
                                    button87y4ko9k,
                                    _model.homePageWalkthroughController,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Avg: ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        widget.setChartUnits == 'mgdl'
                                            ? valueOrDefault<String>(
                                                formatNumber(
                                                  _model.bloodSugarAvg,
                                                  formatType: FormatType.custom,
                                                  format: '0.00',
                                                  locale: '',
                                                ),
                                                '0.0',
                                              )
                                            : formatNumber(
                                                (_model.bloodSugarAvg!) /
                                                    18.018,
                                                formatType: FormatType.custom,
                                                format: '0.00',
                                                locale: '',
                                              ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        widget.setChartUnits == 'mgdl'
                                            ? 'mg/dl'
                                            : 'mmol/l',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ).addWalkthrough(
                                    rowEm77b6f6,
                                    _model.homePageWalkthroughController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.currentChartDate = () {
                                      if (widget.setInterval == 'daily') {
                                        return functions.decrementDate(
                                            _model.currentChartDate!);
                                      } else if (widget.setInterval ==
                                          'weekly') {
                                        return functions.decrementWeek(
                                            _model.currentChartDate!);
                                      } else {
                                        return functions.decrementMonth(
                                            _model.currentChartDate!);
                                      }
                                    }();
                                    safeSetState(() {});
                                    if (widget.setInterval == 'daily') {
                                      _model.decrementDayReadings =
                                          await queryBGreadingsRecordOnce(
                                        queryBuilder: (bGreadingsRecord) =>
                                            bGreadingsRecord
                                                .where(
                                                  'UserID',
                                                  isEqualTo:
                                                      FFAppState().UserID,
                                                )
                                                .where(
                                                  'Date',
                                                  isEqualTo: functions.getDate(
                                                      _model.currentChartDate!),
                                                )
                                                .orderBy('Time'),
                                      );
                                      _model.bloodSugarAvg =
                                          valueOrDefault<double>(
                                        functions.avgSugarReadings(_model
                                            .decrementDayReadings!
                                            .map((e) => valueOrDefault<double>(
                                                  e.cGMreading,
                                                  0.0,
                                                ))
                                            .toList()),
                                        0.0,
                                      );
                                      _model.dayReadings = _model
                                          .decrementDayReadings!
                                          .toList()
                                          .cast<BGreadingsRecord>();
                                      safeSetState(() {});
                                    } else {
                                      if (widget.setInterval == 'weekly') {
                                        if (_model.currentChartDate! >=
                                            functions.firstDayOfWeek(
                                                getCurrentTimestamp)) {
                                          if (functions.currentDate(
                                                  _model.currentChartDate!) <=
                                              functions.currentDate(
                                                  getCurrentTimestamp)) {
                                            _model.decrementWeekReadings =
                                                await queryBGreadingsRecordOnce(
                                              queryBuilder:
                                                  (bGreadingsRecord) =>
                                                      bGreadingsRecord
                                                          .where(
                                                            'UserID',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .UserID,
                                                          )
                                                          .where(
                                                            'Date',
                                                            isGreaterThanOrEqualTo:
                                                                functions.getDate(
                                                                    functions
                                                                        .firstDayOfWeek(
                                                                            getCurrentTimestamp)),
                                                          )
                                                          .orderBy('Date')
                                                          .orderBy('Time'),
                                            );
                                            _model.bloodSugarAvg =
                                                valueOrDefault<double>(
                                              functions.avgSugarReadings(_model
                                                  .decrementWeekReadings!
                                                  .map((e) =>
                                                      valueOrDefault<double>(
                                                        e.cGMreading,
                                                        0.0,
                                                      ))
                                                  .toList()),
                                              0.0,
                                            );
                                            _model.weekReadings = _model
                                                .decrementWeekReadings!
                                                .toList()
                                                .cast<BGreadingsRecord>();
                                            safeSetState(() {});
                                          } else {
                                            _model.weekReadings = [];
                                            safeSetState(() {});
                                          }
                                        } else {
                                          _model.decrementFullWeekReadings =
                                              await queryBGreadingsRecordOnce(
                                            queryBuilder: (bGreadingsRecord) =>
                                                bGreadingsRecord
                                                    .where(
                                                      'UserID',
                                                      isEqualTo:
                                                          FFAppState().UserID,
                                                    )
                                                    .where(
                                                      'Date',
                                                      isGreaterThanOrEqualTo:
                                                          functions.getDate(functions
                                                              .firstDayOfWeek(_model
                                                                  .currentChartDate!)),
                                                    )
                                                    .where(
                                                      'Date',
                                                      isLessThan: functions.getDate(
                                                          functions.firstDayOfWeek(
                                                              functions
                                                                  .incrementWeek(
                                                                      _model
                                                                          .currentChartDate!))),
                                                    )
                                                    .orderBy('Date')
                                                    .orderBy('Time'),
                                          );
                                          _model.bloodSugarAvg =
                                              valueOrDefault<double>(
                                            functions.avgSugarReadings(_model
                                                .decrementFullWeekReadings!
                                                .map((e) =>
                                                    valueOrDefault<double>(
                                                      e.cGMreading,
                                                      0.0,
                                                    ))
                                                .toList()),
                                            0.0,
                                          );
                                          _model.weekReadings = _model
                                              .decrementFullWeekReadings!
                                              .toList()
                                              .cast<BGreadingsRecord>();
                                          safeSetState(() {});
                                        }
                                      } else {
                                        if (_model.currentChartDate! >=
                                            functions.firstDayOfMonth(
                                                getCurrentTimestamp)) {
                                          if (functions.currentDate(
                                                  _model.currentChartDate!) <=
                                              functions.currentDate(
                                                  getCurrentTimestamp)) {
                                            _model.decrementMonthReadings =
                                                await queryBGreadingsRecordOnce(
                                              queryBuilder:
                                                  (bGreadingsRecord) =>
                                                      bGreadingsRecord
                                                          .where(
                                                            'UserID',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .UserID,
                                                          )
                                                          .where(
                                                            'Date',
                                                            isGreaterThanOrEqualTo:
                                                                functions.getDate(
                                                                    functions
                                                                        .firstDayOfMonth(
                                                                            getCurrentTimestamp)),
                                                          )
                                                          .orderBy('Date')
                                                          .orderBy('Time'),
                                            );
                                            _model.bloodSugarAvg =
                                                valueOrDefault<double>(
                                              functions.avgSugarReadings(_model
                                                  .decrementMonthReadings!
                                                  .map((e) =>
                                                      valueOrDefault<double>(
                                                        e.cGMreading,
                                                        0.0,
                                                      ))
                                                  .toList()),
                                              0.0,
                                            );
                                            _model.monthReadings = _model
                                                .decrementMonthReadings!
                                                .toList()
                                                .cast<BGreadingsRecord>();
                                            safeSetState(() {});
                                          } else {
                                            _model.monthReadings = [];
                                            safeSetState(() {});
                                          }
                                        } else {
                                          _model.decrementFullMonthReadings =
                                              await queryBGreadingsRecordOnce(
                                            queryBuilder: (bGreadingsRecord) =>
                                                bGreadingsRecord
                                                    .where(
                                                      'UserID',
                                                      isEqualTo:
                                                          FFAppState().UserID,
                                                    )
                                                    .where(
                                                      'Date',
                                                      isGreaterThanOrEqualTo:
                                                          functions.getDate(functions
                                                              .firstDayOfMonth(
                                                                  _model
                                                                      .currentChartDate!)),
                                                    )
                                                    .where(
                                                      'Date',
                                                      isLessThan: functions.getDate(
                                                          functions.firstDayOfMonth(
                                                              functions
                                                                  .incrementMonth(
                                                                      _model
                                                                          .currentChartDate!))),
                                                    )
                                                    .orderBy('Date')
                                                    .orderBy('Time'),
                                          );
                                          _model.bloodSugarAvg =
                                              valueOrDefault<double>(
                                            functions.avgSugarReadings(_model
                                                .decrementFullMonthReadings!
                                                .map((e) =>
                                                    valueOrDefault<double>(
                                                      e.cGMreading,
                                                      0.0,
                                                    ))
                                                .toList()),
                                            0.0,
                                          );
                                          _model.monthReadings = _model
                                              .decrementFullMonthReadings!
                                              .toList()
                                              .cast<BGreadingsRecord>();
                                          safeSetState(() {});
                                        }
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    Icons.chevron_left_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 30.0,
                                  ),
                                ).addWalkthrough(
                                  iconT8nhjquh,
                                  _model.homePageWalkthroughController,
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    final _datePickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: getCurrentTimestamp,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2050),
                                      builder: (context, child) {
                                        return wrapInMaterialDatePickerTheme(
                                          context,
                                          child!,
                                          headerBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          headerForegroundColor:
                                              FlutterFlowTheme.of(context).info,
                                          headerTextStyle: FlutterFlowTheme.of(
                                                  context)
                                              .headlineLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .fontStyle,
                                                ),
                                                fontSize: 32.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                          pickerBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          pickerForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          selectedDateTimeBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          selectedDateTimeForegroundColor:
                                              FlutterFlowTheme.of(context).info,
                                          actionButtonForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          iconSize: 24.0,
                                        );
                                      },
                                    );

                                    if (_datePickedDate != null) {
                                      safeSetState(() {
                                        _model.datePicked = DateTime(
                                          _datePickedDate.year,
                                          _datePickedDate.month,
                                          _datePickedDate.day,
                                        );
                                      });
                                    } else if (_model.datePicked != null) {
                                      safeSetState(() {
                                        _model.datePicked = getCurrentTimestamp;
                                      });
                                    }
                                    _model.currentChartDate = _model.datePicked;
                                    safeSetState(() {});
                                    if (widget.setInterval == 'daily') {
                                      _model.newTodayReadings =
                                          await queryBGreadingsRecordOnce(
                                        queryBuilder: (bGreadingsRecord) =>
                                            bGreadingsRecord
                                                .where(
                                                  'UserID',
                                                  isEqualTo:
                                                      FFAppState().UserID,
                                                )
                                                .where(
                                                  'Date',
                                                  isEqualTo: functions.getDate(
                                                      _model.currentChartDate!),
                                                )
                                                .orderBy('Time'),
                                      );
                                      _model.bloodSugarAvg =
                                          valueOrDefault<double>(
                                        functions.avgSugarReadings(_model
                                            .newTodayReadings!
                                            .map((e) => e.cGMreading)
                                            .toList()),
                                        0.0,
                                      );
                                      _model.dayReadings = _model
                                          .newTodayReadings!
                                          .toList()
                                          .cast<BGreadingsRecord>();
                                      safeSetState(() {});
                                    } else {
                                      if (widget.setInterval == 'weekly') {
                                        if (_model.currentChartDate! >=
                                            functions.firstDayOfWeek(
                                                getCurrentTimestamp)) {
                                          if (functions.currentDate(
                                                  _model.currentChartDate!) <=
                                              functions.currentDate(
                                                  getCurrentTimestamp)) {
                                            _model.newWeekReadings =
                                                await queryBGreadingsRecordOnce(
                                              queryBuilder:
                                                  (bGreadingsRecord) =>
                                                      bGreadingsRecord
                                                          .where(
                                                            'UserID',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .UserID,
                                                          )
                                                          .where(
                                                            'Date',
                                                            isGreaterThanOrEqualTo:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions.getDate(
                                                                  functions
                                                                      .firstDayOfWeek(
                                                                          getCurrentTimestamp)),
                                                              '01-01-2025',
                                                            ),
                                                          )
                                                          .orderBy('Date')
                                                          .orderBy('Time'),
                                            );
                                            _model.bloodSugarAvg =
                                                valueOrDefault<double>(
                                              functions.avgSugarReadings(_model
                                                  .newWeekReadings!
                                                  .map((e) => e.cGMreading)
                                                  .toList()),
                                              0.0,
                                            );
                                            _model.weekReadings = _model
                                                .newWeekReadings!
                                                .toList()
                                                .cast<BGreadingsRecord>();
                                            safeSetState(() {});
                                          } else {
                                            _model.weekReadings = [];
                                            safeSetState(() {});
                                          }
                                        } else {
                                          _model.newPastWeekReadings =
                                              await queryBGreadingsRecordOnce(
                                            queryBuilder: (bGreadingsRecord) =>
                                                bGreadingsRecord
                                                    .where(
                                                      'UserID',
                                                      isEqualTo:
                                                          FFAppState().UserID,
                                                    )
                                                    .where(
                                                      'Date',
                                                      isGreaterThanOrEqualTo:
                                                          valueOrDefault<
                                                              String>(
                                                        functions.getDate(functions
                                                            .firstDayOfWeek(_model
                                                                .currentChartDate!)),
                                                        '01-01-2025',
                                                      ),
                                                    )
                                                    .where(
                                                      'Date',
                                                      isLessThan:
                                                          valueOrDefault<
                                                              String>(
                                                        functions.getDate(functions
                                                            .firstDayOfWeek(functions
                                                                .incrementWeek(
                                                                    _model
                                                                        .currentChartDate!))),
                                                        '01-01-2025',
                                                      ),
                                                    )
                                                    .orderBy('Date')
                                                    .orderBy('Time'),
                                          );
                                          _model.bloodSugarAvg =
                                              valueOrDefault<double>(
                                            functions.avgSugarReadings(_model
                                                .newPastWeekReadings!
                                                .map((e) => e.cGMreading)
                                                .toList()),
                                            0.0,
                                          );
                                          _model.weekReadings = _model
                                              .newPastWeekReadings!
                                              .toList()
                                              .cast<BGreadingsRecord>();
                                          safeSetState(() {});
                                        }
                                      } else {
                                        if (_model.currentChartDate! >=
                                            functions.firstDayOfMonth(
                                                getCurrentTimestamp)) {
                                          if (functions.currentDate(
                                                  _model.currentChartDate!) <=
                                              functions.currentDate(
                                                  getCurrentTimestamp)) {
                                            _model.newMonthReadings =
                                                await queryBGreadingsRecordOnce(
                                              queryBuilder:
                                                  (bGreadingsRecord) =>
                                                      bGreadingsRecord
                                                          .where(
                                                            'UserID',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .UserID,
                                                          )
                                                          .where(
                                                            'Date',
                                                            isGreaterThanOrEqualTo:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions.getDate(
                                                                  functions
                                                                      .firstDayOfMonth(
                                                                          getCurrentTimestamp)),
                                                              '01-01-2025',
                                                            ),
                                                          )
                                                          .orderBy('Date')
                                                          .orderBy('Time'),
                                            );
                                            _model.bloodSugarAvg =
                                                valueOrDefault<double>(
                                              functions.avgSugarReadings(_model
                                                  .newMonthReadings!
                                                  .map((e) => e.cGMreading)
                                                  .toList()),
                                              0.0,
                                            );
                                            _model.monthReadings = _model
                                                .newMonthReadings!
                                                .toList()
                                                .cast<BGreadingsRecord>();
                                            safeSetState(() {});
                                          } else {
                                            _model.monthReadings = [];
                                            safeSetState(() {});
                                          }
                                        } else {
                                          _model.newPastMonthReadings =
                                              await queryBGreadingsRecordOnce(
                                            queryBuilder: (bGreadingsRecord) =>
                                                bGreadingsRecord
                                                    .where(
                                                      'UserID',
                                                      isEqualTo:
                                                          FFAppState().UserID,
                                                    )
                                                    .where(
                                                      'Date',
                                                      isGreaterThanOrEqualTo:
                                                          valueOrDefault<
                                                              String>(
                                                        functions.getDate(functions
                                                            .firstDayOfMonth(_model
                                                                .currentChartDate!)),
                                                        '01-01-2025',
                                                      ),
                                                    )
                                                    .where(
                                                      'Date',
                                                      isLessThan:
                                                          valueOrDefault<
                                                              String>(
                                                        functions.getDate(functions
                                                            .firstDayOfMonth(functions
                                                                .incrementMonth(
                                                                    _model
                                                                        .currentChartDate!))),
                                                        '01-01-2025',
                                                      ),
                                                    )
                                                    .orderBy('Date')
                                                    .orderBy('Time'),
                                          );
                                          _model.bloodSugarAvg =
                                              valueOrDefault<double>(
                                            functions.avgSugarReadings(_model
                                                .newPastMonthReadings!
                                                .map((e) => e.cGMreading)
                                                .toList()),
                                            0.0,
                                          );
                                          _model.monthReadings = _model
                                              .newPastMonthReadings!
                                              .toList()
                                              .cast<BGreadingsRecord>();
                                          safeSetState(() {});
                                        }
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                  text: _model.currentChartDate != null
                                      ? () {
                                          if (widget.setInterval == 'daily') {
                                            return dateTimeFormat("yMMMd",
                                                _model.currentChartDate);
                                          } else if (widget.setInterval ==
                                              'weekly') {
                                            return '${dateTimeFormat("d/M/y", functions.firstDayOfWeek(_model.currentChartDate!))} - ${(_model.currentChartDate! >= functions.firstDayOfWeek(getCurrentTimestamp)) && (functions.currentDate(_model.currentChartDate!) <= functions.currentDate(getCurrentTimestamp)) ? dateTimeFormat("d/M/y", getCurrentTimestamp) : dateTimeFormat("d/M/y", functions.lastDayOfWeek(_model.currentChartDate!))}';
                                          } else {
                                            return '${functions.monthName(_model.currentChartDate!)}, ${functions.getYear(functions.getDate(_model.currentChartDate!)).toString()}';
                                          }
                                        }()
                                      : getCurrentTimestamp.toString(),
                                  options: FFButtonOptions(
                                    height: 30.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ).addWalkthrough(
                                  buttonWq2dzgnj,
                                  _model.homePageWalkthroughController,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.currentChartDate = () {
                                      if (widget.setInterval == 'daily') {
                                        return functions.incrementDate(
                                            _model.currentChartDate!);
                                      } else if (widget.setInterval ==
                                          'weekly') {
                                        return functions.incrementWeek(
                                            _model.currentChartDate!);
                                      } else {
                                        return functions.incrementMonth(
                                            _model.currentChartDate!);
                                      }
                                    }();
                                    safeSetState(() {});
                                    if (widget.setInterval == 'daily') {
                                      _model.incrementTodayReadings =
                                          await queryBGreadingsRecordOnce(
                                        queryBuilder: (bGreadingsRecord) =>
                                            bGreadingsRecord
                                                .where(
                                                  'UserID',
                                                  isEqualTo:
                                                      FFAppState().UserID,
                                                )
                                                .where(
                                                  'Date',
                                                  isEqualTo: functions.getDate(
                                                      _model.currentChartDate!),
                                                )
                                                .orderBy('Time'),
                                      );
                                      _model.bloodSugarAvg =
                                          valueOrDefault<double>(
                                        functions.avgSugarReadings(_model
                                            .incrementTodayReadings!
                                            .map((e) => e.cGMreading)
                                            .toList()),
                                        0.0,
                                      );
                                      _model.dayReadings = _model
                                          .incrementTodayReadings!
                                          .toList()
                                          .cast<BGreadingsRecord>();
                                      safeSetState(() {});
                                    } else {
                                      if (widget.setInterval == 'weekly') {
                                        if (_model.currentChartDate! >=
                                            functions.firstDayOfWeek(
                                                getCurrentTimestamp)) {
                                          if (functions.currentDate(
                                                  _model.currentChartDate!) <=
                                              functions.currentDate(
                                                  getCurrentTimestamp)) {
                                            _model.incrementWeekReadings =
                                                await queryBGreadingsRecordOnce(
                                              queryBuilder:
                                                  (bGreadingsRecord) =>
                                                      bGreadingsRecord
                                                          .where(
                                                            'UserID',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .UserID,
                                                          )
                                                          .where(
                                                            'Date',
                                                            isGreaterThanOrEqualTo:
                                                                functions.getDate(
                                                                    functions
                                                                        .firstDayOfWeek(
                                                                            getCurrentTimestamp)),
                                                          )
                                                          .orderBy('Date')
                                                          .orderBy('Time'),
                                            );
                                            _model.bloodSugarAvg =
                                                valueOrDefault<double>(
                                              functions.avgSugarReadings(_model
                                                  .incrementWeekReadings!
                                                  .map((e) => e.cGMreading)
                                                  .toList()),
                                              0.0,
                                            );
                                            _model.weekReadings = _model
                                                .incrementWeekReadings!
                                                .toList()
                                                .cast<BGreadingsRecord>();
                                            safeSetState(() {});
                                          } else {
                                            _model.weekReadings = [];
                                            safeSetState(() {});
                                          }
                                        } else {
                                          _model.incrementFullWeekReadings =
                                              await queryBGreadingsRecordOnce(
                                            queryBuilder: (bGreadingsRecord) =>
                                                bGreadingsRecord
                                                    .where(
                                                      'UserID',
                                                      isEqualTo:
                                                          FFAppState().UserID,
                                                    )
                                                    .where(
                                                      'Date',
                                                      isGreaterThanOrEqualTo:
                                                          functions.getDate(functions
                                                              .firstDayOfWeek(_model
                                                                  .currentChartDate!)),
                                                    )
                                                    .where(
                                                      'Date',
                                                      isLessThan: functions.getDate(
                                                          functions.firstDayOfWeek(
                                                              functions
                                                                  .incrementWeek(
                                                                      _model
                                                                          .currentChartDate!))),
                                                    )
                                                    .orderBy('Date')
                                                    .orderBy('Time'),
                                          );
                                          _model.bloodSugarAvg =
                                              valueOrDefault<double>(
                                            functions.avgSugarReadings(_model
                                                .incrementFullWeekReadings!
                                                .map((e) => e.cGMreading)
                                                .toList()),
                                            0.0,
                                          );
                                          _model.weekReadings = _model
                                              .incrementFullWeekReadings!
                                              .toList()
                                              .cast<BGreadingsRecord>();
                                          safeSetState(() {});
                                        }
                                      } else {
                                        if (_model.currentChartDate! >=
                                            functions.firstDayOfMonth(
                                                getCurrentTimestamp)) {
                                          if (functions.currentDate(
                                                  _model.currentChartDate!) <=
                                              functions.currentDate(
                                                  getCurrentTimestamp)) {
                                            _model.incrementMonthReadings =
                                                await queryBGreadingsRecordOnce(
                                              queryBuilder:
                                                  (bGreadingsRecord) =>
                                                      bGreadingsRecord
                                                          .where(
                                                            'UserID',
                                                            isEqualTo:
                                                                FFAppState()
                                                                    .UserID,
                                                          )
                                                          .where(
                                                            'Date',
                                                            isGreaterThanOrEqualTo:
                                                                functions.getDate(
                                                                    functions
                                                                        .firstDayOfMonth(
                                                                            getCurrentTimestamp)),
                                                          )
                                                          .orderBy('Date')
                                                          .orderBy('Time'),
                                            );
                                            _model.bloodSugarAvg =
                                                valueOrDefault<double>(
                                              functions.avgSugarReadings(_model
                                                  .incrementMonthReadings!
                                                  .map((e) => e.cGMreading)
                                                  .toList()),
                                              0.0,
                                            );
                                            _model.monthReadings = _model
                                                .incrementMonthReadings!
                                                .toList()
                                                .cast<BGreadingsRecord>();
                                            safeSetState(() {});
                                          } else {
                                            _model.monthReadings = [];
                                            safeSetState(() {});
                                          }
                                        } else {
                                          _model.incrementFullMonthReadings =
                                              await queryBGreadingsRecordOnce(
                                            queryBuilder: (bGreadingsRecord) =>
                                                bGreadingsRecord
                                                    .where(
                                                      'UserID',
                                                      isEqualTo:
                                                          FFAppState().UserID,
                                                    )
                                                    .where(
                                                      'Date',
                                                      isGreaterThanOrEqualTo:
                                                          functions.getDate(functions
                                                              .firstDayOfMonth(
                                                                  _model
                                                                      .currentChartDate!)),
                                                    )
                                                    .where(
                                                      'Date',
                                                      isLessThan: functions.getDate(
                                                          functions.firstDayOfMonth(
                                                              functions
                                                                  .incrementMonth(
                                                                      _model
                                                                          .currentChartDate!))),
                                                    )
                                                    .orderBy('Date')
                                                    .orderBy('Time'),
                                          );
                                          _model.bloodSugarAvg =
                                              valueOrDefault<double>(
                                            functions.avgSugarReadings(_model
                                                .incrementFullMonthReadings!
                                                .map((e) => e.cGMreading)
                                                .toList()),
                                            0.0,
                                          );
                                          _model.monthReadings = _model
                                              .incrementFullMonthReadings!
                                              .toList()
                                              .cast<BGreadingsRecord>();
                                          safeSetState(() {});
                                        }
                                      }
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 30.0,
                                  ),
                                ).addWalkthrough(
                                  icon6gs0ni15,
                                  _model.homePageWalkthroughController,
                                ),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (widget.setChartType == 'single') {
                                return Builder(
                                  builder: (context) {
                                    if (widget.setInterval == 'daily') {
                                      return Builder(
                                        builder: (context) {
                                          if (widget.setChartUnits == 'mgdl') {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: _model
                                                              .dayReadings
                                                              .map((e) =>
                                                                  e.decimalTime)
                                                              .toList(),
                                                          yData: _model
                                                              .dayReadings
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mgdlUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mgdlLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Time (24hr format)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '00:00',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 50.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'BG Readings'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 60.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: _model
                                                              .dayReadings
                                                              .map((e) =>
                                                                  e.decimalTime)
                                                              .toList(),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .dayReadings
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mmolUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mmolLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Time (24hr format)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '00:00',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'BG Readings'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 60.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else if (widget.setInterval ==
                                        'weekly') {
                                      return Builder(
                                        builder: (context) {
                                          if (widget.setChartUnits == 'mgdl') {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToWeekTimes(
                                                                  _model
                                                                      .weekReadings
                                                                      .toList()),
                                                          yData: _model
                                                              .weekReadings
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mgdlUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mgdlLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Days)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 50.0,
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'BG Readings'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 60.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToWeekTimes(
                                                                  _model
                                                                      .weekReadings
                                                                      .toList()),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .weekReadings
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mmolUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mmolLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Days)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'BG Readings'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 60.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      return Builder(
                                        builder: (context) {
                                          if (widget.setChartUnits == 'mgdl') {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToMonthTimes(
                                                                  _model
                                                                      .monthReadings
                                                                      .toList()),
                                                          yData: _model
                                                              .monthReadings
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mgdlUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mgdlLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Weeks)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 50.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'BG Readings'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 60.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToMonthTimes(
                                                                  _model
                                                                      .monthReadings
                                                                      .toList()),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .monthReadings
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mmolUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mmolLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Weeks)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'BG Readings'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 60.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    }
                                  },
                                );
                              } else {
                                return Builder(
                                  builder: (context) {
                                    if (widget.setInterval == 'daily') {
                                      return Builder(
                                        builder: (context) {
                                          if (widget.setChartUnits == 'mgdl') {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: _model
                                                              .dayReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'before meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.decimalTime)
                                                              .toList(),
                                                          yData: _model
                                                              .dayReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'before meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: _model
                                                              .dayReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'after meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.decimalTime)
                                                              .toList(),
                                                          yData: _model
                                                              .dayReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'after meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mgdlUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mgdlLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Time (24hr format)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '00:00',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 50.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'Before meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                              'After meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 75.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: _model
                                                              .dayReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'before meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.decimalTime)
                                                              .toList(),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: _model
                                                              .dayReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'after meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.decimalTime)
                                                              .toList(),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mmolUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              _model.dayReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .decimalTime)
                                                                  .toList(),
                                                              'daily'),
                                                          yData: _model
                                                              .mmolLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Time (24hr format)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '00:00',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'Before meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                              'After meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 75.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else if (widget.setInterval ==
                                        'weekly') {
                                      return Builder(
                                        builder: (context) {
                                          if (widget.setChartUnits == 'mgdl') {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToWeekTimes(_model
                                                                  .weekReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()),
                                                          yData: _model
                                                              .weekReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'before meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToWeekTimes(_model
                                                                  .weekReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()),
                                                          yData: _model
                                                              .weekReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'after meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mgdlUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mgdlLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Days)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 50.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'Before meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                              'After meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 75.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToWeekTimes(_model
                                                                  .weekReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .weekReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToWeekTimes(_model
                                                                  .weekReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .weekReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mmolUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToWeekTimes(_model
                                                                      .weekReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'weekly'),
                                                          yData: _model
                                                              .mmolLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Days)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'Before meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                              'After meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 75.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      return Builder(
                                        builder: (context) {
                                          if (widget.setChartUnits == 'mgdl') {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToMonthTimes(_model
                                                                  .monthReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()),
                                                          yData: _model
                                                              .monthReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'before meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToMonthTimes(_model
                                                                  .monthReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()),
                                                          yData: _model
                                                              .monthReadings
                                                              .where((e) =>
                                                                  e.period ==
                                                                  'after meal')
                                                              .toList()
                                                              .map((e) =>
                                                                  e.cGMreading)
                                                              .toList(),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mgdlUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mgdlLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Weeks)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 50.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'Before meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                              'After meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 75.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 15.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.492,
                                                child: Stack(
                                                  children: [
                                                    FlutterFlowLineChart(
                                                      data: [
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToMonthTimes(_model
                                                                  .monthReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .monthReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'before meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions
                                                              .convertToMonthTimes(_model
                                                                  .monthReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()),
                                                          yData: functions
                                                              .mgdlToMmol(_model
                                                                  .monthReadings
                                                                  .where((e) =>
                                                                      e.period ==
                                                                      'after meal')
                                                                  .toList()
                                                                  .map((e) => e
                                                                      .cGMreading)
                                                                  .toList()),
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            barWidth: 2.0,
                                                            isCurved: true,
                                                            preventCurveOverShooting:
                                                                true,
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mmolUpperYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        ),
                                                        FFLineChartData(
                                                          xData: functions.xChartBounds(
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'before meal')
                                                                      .toList())
                                                                  .toList(),
                                                              functions
                                                                  .convertToMonthTimes(_model
                                                                      .monthReadings
                                                                      .where((e) =>
                                                                          e.period ==
                                                                          'after meal')
                                                                      .toList())
                                                                  .toList(),
                                                              'monthly'),
                                                          yData: _model
                                                              .mmolLowerYBounds,
                                                          settings:
                                                              LineChartBarData(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            barWidth: 4.0,
                                                            dotData: FlDotData(
                                                                show: false),
                                                          ),
                                                        )
                                                      ],
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .boxShadowColor,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showGrid: true,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        borderWidth: 1.0,
                                                      ),
                                                      axisBounds: AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title: 'Time (Weeks)',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 1.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 15.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        title:
                                                            'Glucose Level (${widget.setChartUnits})',
                                                        titleTextStyle:
                                                            TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            TextStyle(
                                                          fontSize: 13.0,
                                                        ),
                                                        labelInterval: 2.0,
                                                        labelFormatter:
                                                            LabelFormatter(
                                                          numberFormat: (val) =>
                                                              formatNumber(
                                                            val,
                                                            formatType:
                                                                FormatType
                                                                    .custom,
                                                            format: '0',
                                                            locale: 'en_US',
                                                          ),
                                                        ),
                                                        reservedSize: 24.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child:
                                                          FlutterFlowChartLegendWidget(
                                                        entries: [
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              'Before meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                              'After meal'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                              'Hyper-Limit'),
                                                          LegendEntry(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .warning,
                                                              'Hypo-Limit'),
                                                        ],
                                                        width: 100.0,
                                                        height: 75.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      11.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        textPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    5.0,
                                                                    0.0),
                                                        borderWidth: 1.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        indicatorSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ).addWalkthrough(
                        columnVn3qc0p9,
                        _model.homePageWalkthroughController,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add_card,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Add logs',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: BglogsWidget(
                                                prevChartDate: _model
                                                            .currentChartDate !=
                                                        null
                                                    ? _model.currentChartDate!
                                                    : getCurrentTimestamp,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 3.0),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                        Text(
                                          'BG readings',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ).addWalkthrough(
                                    columnVg2795vw,
                                    _model.homePageWalkthroughController,
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: AccessFromMainTabWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 3.0),
                                          child: Icon(
                                            Icons.fastfood_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                        Text(
                                          'Food & Drink',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ).addWalkthrough(
                                    column6i2abtnq,
                                    _model.homePageWalkthroughController,
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: AddactivityWidget(
                                                completed: true,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 3.0),
                                          child: Icon(
                                            Icons.directions_run_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                        Text(
                                          'Activity',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ).addWalkthrough(
                                    columnVj5rx2ra,
                                    _model.homePageWalkthroughController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).addWalkthrough(
                          columnT8kwqqqg,
                          _model.homePageWalkthroughController,
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TutorialCoachMark createPageWalkthrough(BuildContext context) =>
      TutorialCoachMark(
        targets: createWalkthroughTargets(context),
        onFinish: () async {
          safeSetState(() => _model.homePageWalkthroughController = null);
        },
        onSkip: () {
          return true;
        },
      );
}
