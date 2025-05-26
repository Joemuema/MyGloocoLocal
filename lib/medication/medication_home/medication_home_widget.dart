import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/medication/home_reminder/home_reminder_widget.dart';
import '/medication/med_menu/med_menu_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import '/medication/past_reminder/past_reminder_widget.dart';
import '/medication/refill/refill_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'medication_home_model.dart';
export 'medication_home_model.dart';

class MedicationHomeWidget extends StatefulWidget {
  const MedicationHomeWidget({super.key});

  static String routeName = 'MedicationHome';
  static String routePath = '/medicationHome';

  @override
  State<MedicationHomeWidget> createState() => _MedicationHomeWidgetState();
}

class _MedicationHomeWidgetState extends State<MedicationHomeWidget> {
  late MedicationHomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedicationHomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.today = functions.getDate(getCurrentTimestamp);
      _model.expandedCalendar = false;
      safeSetState(() {});
      _model.allReminders = await queryRemindersRecordOnce(
        queryBuilder: (remindersRecord) => remindersRecord.where(
          'UserID',
          isEqualTo: FFAppState().UserID,
        ),
      );
      _model.currentSubReminders = await queryIndividualRemindersRecordOnce(
        queryBuilder: (individualRemindersRecord) => individualRemindersRecord
            .where(
              'UserID',
              isEqualTo: FFAppState().UserID,
            )
            .where(
              'Date',
              isEqualTo: _model.today,
            ),
      );
      _model.listOfUpcomingTimes = functions
          .combineTimeLists(
              _model.allReminders!
                  .where((e) =>
                      (e.date == functions.getDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .map((e) => e.time)
                  .toList()
                  .toList(),
              _model.allReminders!
                  .where((e) =>
                      (e.frequency == 'Daily') &&
                      (e.fIrstDateTime! <=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (e.lastDateTime! >=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .map((e) => e.time)
                  .toList()
                  .toList(),
              _model.allReminders!
                  .where((e) =>
                      (e.frequency == 'Weekly') &&
                      (e.day == functions.getDayofWeek(getCurrentTimestamp)) &&
                      (e.fIrstDateTime! <=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (e.lastDateTime! >=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .map((e) => e.time)
                  .toList()
                  .toList(),
              _model.allReminders!
                  .where((e) =>
                      (e.frequency == 'Monthly') &&
                      (e.dateNumber ==
                          functions.extractDayNumber(getCurrentTimestamp)) &&
                      (e.fIrstDateTime! <=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (e.lastDateTime! >=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .map((e) => e.time)
                  .toList()
                  .toList())!
          .sortedList(keyOf: (e) => e, desc: false)
          .unique((e) => e)
          .toList()
          .cast<String>();
      _model.upcomingReminders = functions
          .combineReminderLists(
              _model.allReminders!
                  .where((e) =>
                      (e.date == functions.getDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .toList(),
              _model.allReminders!
                  .where((e) =>
                      (e.frequency == 'Daily') &&
                      (e.fIrstDateTime! <=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (e.lastDateTime! >=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .toList(),
              _model.allReminders!
                  .where((e) =>
                      (e.frequency == 'Weekly') &&
                      (e.day == functions.getDayofWeek(getCurrentTimestamp)) &&
                      (e.fIrstDateTime! <=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (e.lastDateTime! >=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .toList(),
              _model.allReminders!
                  .where((e) =>
                      (e.frequency == 'Monthly') &&
                      (e.dateNumber ==
                          functions.extractDayNumber(getCurrentTimestamp)) &&
                      (e.fIrstDateTime! <=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (e.lastDateTime! >=
                          functions.currentDate(getCurrentTimestamp)) &&
                      (functions.todayTime(e.time) >= getCurrentTimestamp))
                  .toList()
                  .toList())!
          .toList()
          .cast<RemindersRecord>();
      _model.listOfTakenTimes = _model.currentSubReminders!
          .where((e) =>
              (e.status == 'Taken') &&
              (functions.todayTime(e.time) < getCurrentTimestamp))
          .toList()
          .map((e) => e.time)
          .toList()
          .unique((e) => e)
          .sortedList(keyOf: (e) => e, desc: false)
          .toList()
          .cast<String>();
      _model.takenReminders = _model.currentSubReminders!
          .where((e) =>
              (e.status == 'Taken') &&
              (functions.todayTime(e.time) < getCurrentTimestamp))
          .toList()
          .toList()
          .cast<IndividualRemindersRecord>();
      _model.listOfMissedTimes = _model.currentSubReminders!
          .where((e) =>
              (e.status == 'Missed') &&
              (functions.todayTime(e.time) < getCurrentTimestamp))
          .toList()
          .map((e) => e.time)
          .toList()
          .unique((e) => e)
          .sortedList(keyOf: (e) => e, desc: false)
          .toList()
          .cast<String>();
      _model.missedReminders = _model.currentSubReminders!
          .where((e) =>
              (e.status == 'Missed') &&
              (functions.todayTime(e.time) < getCurrentTimestamp))
          .toList()
          .toList()
          .cast<IndividualRemindersRecord>();
      safeSetState(() {});
      if (FFAppState().notificationPermissionsGranted == false) {
        _model.permissionsGranted = await actions.requestPermissions();
        FFAppState().notificationPermissionsGranted =
            _model.permissionsGranted!;
        safeSetState(() {});
      }
      _model.lowCapacityMeds = await queryMedicineRecordOnce(
        queryBuilder: (medicineRecord) => medicineRecord
            .where(
              'UserID',
              isEqualTo: FFAppState().UserID,
            )
            .where(
              'TotalDose',
              isLessThanOrEqualTo: 4.0,
            ),
      );
      if ((_model.lowCapacityMeds != null &&
              (_model.lowCapacityMeds)!.isNotEmpty) ==
          true) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: RefillWidget(
                  medRefillList: _model.lowCapacityMeds,
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
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
        floatingActionButton: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 60.0),
          child: FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: MedMenuWidget(),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8.0,
            child: Icon(
              Icons.menu_open,
              color: FlutterFlowTheme.of(context).info,
              size: 24.0,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Medicine Schedule',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        if (_model.expandedCalendar) {
                          return FlutterFlowCalendar(
                            color: FlutterFlowTheme.of(context).primary,
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            weekFormat: false,
                            weekStartsMonday: false,
                            initialDate: _model.datePicked != null
                                ? _model.calendarDateTime
                                : getCurrentTimestamp,
                            rowHeight: 64.0,
                            onChange: (DateTimeRange? newSelectedDate) async {
                              if (_model.calendarSelectedDay1 ==
                                  newSelectedDate) {
                                return;
                              }
                              _model.calendarSelectedDay1 = newSelectedDate;
                              _model.calendarDate = valueOrDefault<String>(
                                functions.getDate(
                                    _model.calendarSelectedDay1!.start),
                                'date',
                              );
                              safeSetState(() {});
                              if (_model.calendarChanged == true) {
                                _model.calendarChanged = false;
                                safeSetState(() {});
                              }
                              _model.exCalendarReminders =
                                  await queryRemindersRecordOnce(
                                queryBuilder: (remindersRecord) =>
                                    remindersRecord.where(
                                  'UserID',
                                  isEqualTo: FFAppState().UserID,
                                ),
                              );
                              if (functions.getDate(
                                      _model.calendarSelectedDay1!.start) ==
                                  functions.getDate(functions
                                      .currentDate(getCurrentTimestamp))) {
                                _model.exTodaySubReminders =
                                    await queryIndividualRemindersRecordOnce(
                                  queryBuilder: (individualRemindersRecord) =>
                                      individualRemindersRecord
                                          .where(
                                            'UserID',
                                            isEqualTo: FFAppState().UserID,
                                          )
                                          .where(
                                            'Date',
                                            isEqualTo: valueOrDefault<String>(
                                              _model.today,
                                              'date',
                                            ),
                                          ),
                                );
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (e.timeDT! >= functions.commonTimeDT(getCurrentTimestamp)))
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              } else {
                                _model.exCalendarSubReminders =
                                    await queryIndividualRemindersRecordOnce(
                                  queryBuilder: (individualRemindersRecord) =>
                                      individualRemindersRecord
                                          .where(
                                            'UserID',
                                            isEqualTo: FFAppState().UserID,
                                          )
                                          .where(
                                            'Date',
                                            isEqualTo: valueOrDefault<String>(
                                              _model.calendarDate,
                                              'date',
                                            ),
                                          ),
                                );
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay1!.start)) &&
                                                (_model.calendarSelectedDay1!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay1!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay1!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList().map((e) => e.time).toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay1!.start)) &&
                                                (_model.calendarSelectedDay1!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList(),
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay1!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay1!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start)))
                                            .toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              }

                              safeSetState(() {});
                            },
                            titleStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                            dayOfWeekStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                            dateStyle: FlutterFlowTheme.of(context)
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
                            selectedDateStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            inactiveDateStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                          );
                        } else {
                          return FlutterFlowCalendar(
                            color: FlutterFlowTheme.of(context).primary,
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            weekFormat: true,
                            weekStartsMonday: false,
                            initialDate: _model.datePicked != null
                                ? _model.datePicked
                                : getCurrentTimestamp,
                            rowHeight: 64.0,
                            onChange: (DateTimeRange? newSelectedDate) async {
                              if (_model.calendarSelectedDay2 ==
                                  newSelectedDate) {
                                return;
                              }
                              _model.calendarSelectedDay2 = newSelectedDate;
                              _model.calendarDate = valueOrDefault<String>(
                                functions.getDate(
                                    _model.calendarSelectedDay2!.start),
                                'date',
                              );
                              safeSetState(() {});
                              if (_model.calendarChanged == true) {
                                _model.calendarChanged = false;
                                safeSetState(() {});
                              }
                              _model.calendarReminders =
                                  await queryRemindersRecordOnce(
                                queryBuilder: (remindersRecord) =>
                                    remindersRecord.where(
                                  'UserID',
                                  isEqualTo: FFAppState().UserID,
                                ),
                              );
                              if (functions.getDate(
                                      _model.calendarSelectedDay2!.start) ==
                                  functions.getDate(functions
                                      .currentDate(getCurrentTimestamp))) {
                                _model.todaySubReminders =
                                    await queryIndividualRemindersRecordOnce(
                                  queryBuilder: (individualRemindersRecord) =>
                                      individualRemindersRecord
                                          .where(
                                            'UserID',
                                            isEqualTo: FFAppState().UserID,
                                          )
                                          .where(
                                            'Date',
                                            isEqualTo: valueOrDefault<String>(
                                              _model.today,
                                              'date',
                                            ),
                                          ),
                                );
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (e.timeDT! >= functions.commonTimeDT(getCurrentTimestamp)))
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              } else {
                                _model.calendarSubReminders =
                                    await queryIndividualRemindersRecordOnce(
                                  queryBuilder: (individualRemindersRecord) =>
                                      individualRemindersRecord
                                          .where(
                                            'UserID',
                                            isEqualTo: FFAppState().UserID,
                                          )
                                          .where(
                                            'Date',
                                            isEqualTo: valueOrDefault<String>(
                                              _model.calendarDate,
                                              'date',
                                            ),
                                          ),
                                );
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay2!.start)) &&
                                                (_model.calendarSelectedDay2!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay2!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay2!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList().map((e) => e.time).toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay2!.start)) &&
                                                (_model.calendarSelectedDay2!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList(),
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay2!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay2!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start)))
                                            .toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              }

                              safeSetState(() {});
                            },
                            titleStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                            dayOfWeekStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                            dateStyle: FlutterFlowTheme.of(context)
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
                            selectedDateStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            inactiveDateStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                          );
                        }
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            45.0, 17.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.expandedCalendar = !_model.expandedCalendar;
                            safeSetState(() {});
                            if (_model.expandedCalendar == true) {
                              if (functions.getDate(
                                      _model.calendarSelectedDay2!.start) ==
                                  functions.getDate(functions
                                      .currentDate(getCurrentTimestamp))) {
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (e.timeDT! >= functions.commonTimeDT(getCurrentTimestamp)))
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .todaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              } else {
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay2!.start)) &&
                                                (_model.calendarSelectedDay2!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay2!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay2!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList().map((e) => e.time).toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay2!.start)) &&
                                                (_model.calendarSelectedDay2!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList(),
                                        _model.calendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay2!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay2!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start)))
                                            .toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList(),
                                        _model.calendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay2!.start)) && (_model.calendarSelectedDay2!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay2!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay2!.start))).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .calendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay2!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              }
                            } else {
                              if (functions.getDate(
                                      _model.calendarSelectedDay1!.start) ==
                                  functions.getDate(functions
                                      .currentDate(getCurrentTimestamp))) {
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.date ==
                                                    functions.getDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.lastDateTime! >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (functions.todayTime(e.time) >=
                                                    getCurrentTimestamp))
                                            .toList(),
                                        _model.allReminders!
                                            .where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (e.timeDT! >= functions.commonTimeDT(getCurrentTimestamp)))
                                            .toList(),
                                        _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .exTodaySubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (functions.todayTime(e.time) <
                                            getCurrentTimestamp))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              } else {
                                _model.listOfUpcomingTimes = functions
                                    .combineTimeLists(
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay1!.start)) &&
                                                (_model.calendarSelectedDay1!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay1!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay1!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start)))
                                            .toList()
                                            .map((e) => e.time)
                                            .toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList().map((e) => e.time).toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList().map((e) => e.time).toList())!
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .unique((e) => e)
                                    .toList()
                                    .cast<String>();
                                _model.upcomingReminders = functions
                                    .combineReminderLists(
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.date == functions.getDate(_model.calendarSelectedDay1!.start)) &&
                                                (_model.calendarSelectedDay1!.start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)))
                                            .toList(),
                                        _model.exCalendarReminders!
                                            .where((e) =>
                                                (e.frequency == 'Daily') &&
                                                (_model.calendarSelectedDay1!
                                                        .start >=
                                                    functions.currentDate(
                                                        getCurrentTimestamp)) &&
                                                (e.fIrstDateTime! <=
                                                    functions.currentDate(_model.calendarSelectedDay1!.start)) &&
                                                (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start)))
                                            .toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList(),
                                        _model.exCalendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay1!.start)) && (_model.calendarSelectedDay1!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay1!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay1!.start))).toList())!
                                    .toList()
                                    .cast<RemindersRecord>();
                                _model.listOfTakenTimes = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.takenReminders = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Taken') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                _model.listOfMissedTimes = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .map((e) => e.time)
                                    .toList()
                                    .unique((e) => e)
                                    .sortedList(keyOf: (e) => e, desc: false)
                                    .toList()
                                    .cast<String>();
                                _model.missedReminders = _model
                                    .exCalendarSubReminders!
                                    .where((e) =>
                                        (e.status == 'Missed') &&
                                        (_model.calendarSelectedDay1!.start <
                                            functions.currentDate(
                                                getCurrentTimestamp)))
                                    .toList()
                                    .cast<IndividualRemindersRecord>();
                                safeSetState(() {});
                              }
                            }

                            _model.calendarChanged = true;
                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.expand,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 26.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.9, -0.98),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          final _datePickedDate = await showDatePicker(
                            context: context,
                            initialDate: getCurrentTimestamp,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2050),
                            builder: (context, child) {
                              return wrapInMaterialDatePickerTheme(
                                context,
                                child!,
                                headerBackgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                headerForegroundColor:
                                    FlutterFlowTheme.of(context).info,
                                headerTextStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .fontStyle,
                                      ),
                                      fontSize: 32.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .fontStyle,
                                    ),
                                pickerBackgroundColor:
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                pickerForegroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                selectedDateTimeBackgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                selectedDateTimeForegroundColor:
                                    FlutterFlowTheme.of(context).info,
                                actionButtonForegroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
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
                          _model.calendarDateTime = _model.datePicked;
                          safeSetState(() {});
                        },
                        child: Container(
                          width: 162.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (() {
                              if ((_model.expandedCalendar == true) &&
                                  (_model.calendarChanged == false)) {
                                return _model.calendarSelectedDay1!.start;
                              } else if ((_model.expandedCalendar == false) &&
                                  (_model.calendarChanged == false)) {
                                return _model.calendarSelectedDay2!.start;
                              } else if ((_model.expandedCalendar == true) &&
                                  (_model.calendarChanged == true)) {
                                return _model.calendarSelectedDay2!.start;
                              } else if ((_model.expandedCalendar == false) &&
                                  (_model.calendarChanged == true)) {
                                return _model.calendarSelectedDay1!.start;
                              } else {
                                return getCurrentTimestamp;
                              }
                            }() >=
                            functions.currentDate(getCurrentTimestamp))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Upcoming Reminders',
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
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final generatingTimeList =
                                        _model.listOfUpcomingTimes.toList();

                                    return ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: generatingTimeList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 5.0),
                                      itemBuilder:
                                          (context, generatingTimeListIndex) {
                                        final generatingTimeListItem =
                                            generatingTimeList[
                                                generatingTimeListIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 5.0, 10.0, 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      generatingTimeListItem,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      final specificTimeReminderList =
                                                          _model
                                                              .upcomingReminders
                                                              .where((e) =>
                                                                  e.time ==
                                                                  generatingTimeListItem)
                                                              .toList();

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            specificTimeReminderList
                                                                .length,
                                                        itemBuilder: (context,
                                                            specificTimeReminderListIndex) {
                                                          final specificTimeReminderListItem =
                                                              specificTimeReminderList[
                                                                  specificTimeReminderListIndex];
                                                          return wrapWithModel(
                                                            model: _model
                                                                .homeReminderModels
                                                                .getModel(
                                                              specificTimeReminderListItem
                                                                  .reference.id,
                                                              specificTimeReminderListIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                HomeReminderWidget(
                                                              key: Key(
                                                                'Keyp8x_${specificTimeReminderListItem.reference.id}',
                                                              ),
                                                              medicineReminder:
                                                                  specificTimeReminderListItem
                                                                      .medicineID!,
                                                              reminderID:
                                                                  specificTimeReminderListItem
                                                                      .reference,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                if ((_model.listOfUpcomingTimes.isNotEmpty) ==
                                    false)
                                  wrapWithModel(
                                    model: _model.noElementsModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NoElementsWidget(
                                      additionalText:
                                          '(Add reminders to trigger later)',
                                      showFirstLine: false,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (() {
                              if ((_model.expandedCalendar == true) &&
                                  (_model.calendarChanged == false)) {
                                return _model.calendarSelectedDay1!.start;
                              } else if ((_model.expandedCalendar == false) &&
                                  (_model.calendarChanged == false)) {
                                return _model.calendarSelectedDay2!.start;
                              } else if ((_model.expandedCalendar == true) &&
                                  (_model.calendarChanged == true)) {
                                return _model.calendarSelectedDay2!.start;
                              } else if ((_model.expandedCalendar == false) &&
                                  (_model.calendarChanged == true)) {
                                return _model.calendarSelectedDay1!.start;
                              } else {
                                return getCurrentTimestamp;
                              }
                            }() <=
                            functions.currentDate(getCurrentTimestamp))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Taken Reminders',
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
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final takenTimeList =
                                        _model.listOfTakenTimes.toList();

                                    return ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: takenTimeList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 5.0),
                                      itemBuilder:
                                          (context, takenTimeListIndex) {
                                        final takenTimeListItem =
                                            takenTimeList[takenTimeListIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 5.0, 10.0, 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      takenTimeListItem,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      final takenReminderList =
                                                          _model.takenReminders
                                                              .where((e) =>
                                                                  e.time ==
                                                                  takenTimeListItem)
                                                              .toList();

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            takenReminderList
                                                                .length,
                                                        itemBuilder: (context,
                                                            takenReminderListIndex) {
                                                          final takenReminderListItem =
                                                              takenReminderList[
                                                                  takenReminderListIndex];
                                                          return PastReminderWidget(
                                                            key: Key(
                                                                'Keyzdi_${takenReminderListIndex}_of_${takenReminderList.length}'),
                                                            reminderRef:
                                                                takenReminderListItem
                                                                    .parentReference,
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                if ((_model.takenReminders.isNotEmpty) == false)
                                  wrapWithModel(
                                    model: _model.noElementsModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NoElementsWidget(
                                      additionalText: '(No medicines taken)',
                                      showFirstLine: false,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (() {
                              if ((_model.expandedCalendar == true) &&
                                  (_model.calendarChanged == false)) {
                                return _model.calendarSelectedDay1!.start;
                              } else if ((_model.expandedCalendar == false) &&
                                  (_model.calendarChanged == false)) {
                                return _model.calendarSelectedDay2!.start;
                              } else if ((_model.expandedCalendar == true) &&
                                  (_model.calendarChanged == true)) {
                                return _model.calendarSelectedDay2!.start;
                              } else if ((_model.expandedCalendar == false) &&
                                  (_model.calendarChanged == true)) {
                                return _model.calendarSelectedDay1!.start;
                              } else {
                                return getCurrentTimestamp;
                              }
                            }() <=
                            functions.currentDate(getCurrentTimestamp))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Missed Reminders',
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
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final missedTimeList =
                                        _model.listOfMissedTimes.toList();

                                    return ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: missedTimeList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 5.0),
                                      itemBuilder:
                                          (context, missedTimeListIndex) {
                                        final missedTimeListItem =
                                            missedTimeList[missedTimeListIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 5.0, 10.0, 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      missedTimeListItem,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      final missedTimeReminderList =
                                                          _model.missedReminders
                                                              .where((e) =>
                                                                  e.time ==
                                                                  missedTimeListItem)
                                                              .toList();

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            missedTimeReminderList
                                                                .length,
                                                        itemBuilder: (context,
                                                            missedTimeReminderListIndex) {
                                                          final missedTimeReminderListItem =
                                                              missedTimeReminderList[
                                                                  missedTimeReminderListIndex];
                                                          return PastReminderWidget(
                                                            key: Key(
                                                                'Keylz6_${missedTimeReminderListIndex}_of_${missedTimeReminderList.length}'),
                                                            reminderRef:
                                                                missedTimeReminderListItem
                                                                    .parentReference,
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                if ((_model.missedReminders.isNotEmpty) ==
                                    false)
                                  wrapWithModel(
                                    model: _model.noElementsModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NoElementsWidget(
                                      additionalText: '(No reminders missed)',
                                      showFirstLine: false,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (() {
                      if ((_model.expandedCalendar == true) &&
                          (_model.calendarChanged == false)) {
                        return _model.calendarSelectedDay1!.start;
                      } else if ((_model.expandedCalendar == false) &&
                          (_model.calendarChanged == false)) {
                        return _model.calendarSelectedDay2!.start;
                      } else if ((_model.expandedCalendar == true) &&
                          (_model.calendarChanged == true)) {
                        return _model.calendarSelectedDay2!.start;
                      } else if ((_model.expandedCalendar == false) &&
                          (_model.calendarChanged == true)) {
                        return _model.calendarSelectedDay1!.start;
                      } else {
                        return getCurrentTimestamp;
                      }
                    }() >=
                    functions.currentDate(getCurrentTimestamp))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              MedicationListWidget.routeName,
                              queryParameters: {
                                'listOption': serializeParam(
                                  'add',
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: 'Add reminder',
                          icon: Icon(
                            Icons.add_alarm_rounded,
                            size: 24.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
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
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
