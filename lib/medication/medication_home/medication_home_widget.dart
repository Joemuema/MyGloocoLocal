import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/medication/home_reminder/home_reminder_widget.dart';
import '/medication/med_menu/med_menu_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import '/medication/past_reminder/past_reminder_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'medication_home_model.dart';
export 'medication_home_model.dart';

class MedicationHomeWidget extends StatefulWidget {
  const MedicationHomeWidget({super.key});

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
              isEqualTo: 'date',
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
      setState(() {});
      if (FFAppState().notificationPermissionsGranted == false) {
        _model.permissionsGranted = await actions.requestPermissions();
        FFAppState().notificationPermissionsGranted =
            _model.permissionsGranted!;
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () => _model.unfocusNode.canRequestFocus
                      ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                      : FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: const MedMenuWidget(),
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Medicine Schedule',
            style: FlutterFlowTheme.of(context).displaySmall.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowCalendar(
                  color: FlutterFlowTheme.of(context).primary,
                  iconColor: FlutterFlowTheme.of(context).secondaryText,
                  weekFormat: true,
                  weekStartsMonday: false,
                  initialDate: getCurrentTimestamp,
                  rowHeight: 64.0,
                  onChange: (DateTimeRange? newSelectedDate) async {
                    if (_model.calendarSelectedDay == newSelectedDate) {
                      return;
                    }
                    _model.calendarSelectedDay = newSelectedDate;
                    _model.calendarReminders = await queryRemindersRecordOnce(
                      queryBuilder: (remindersRecord) => remindersRecord.where(
                        'UserID',
                        isEqualTo: FFAppState().UserID,
                      ),
                    );
                    if (functions.getDate(_model.calendarSelectedDay!.start) ==
                        functions.getDate(
                            functions.currentDate(getCurrentTimestamp))) {
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
                                  isEqualTo: 'date',
                                ),
                      );
                      _model.listOfUpcomingTimes = functions
                          .combineTimeLists(
                              _model.allReminders!
                                  .where((e) =>
                                      (e.date == functions.getDate(getCurrentTimestamp)) &&
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
                                  .where((e) =>
                                      (e.frequency == 'Weekly') &&
                                      (e.day ==
                                          functions.getDayofWeek(
                                              getCurrentTimestamp)) &&
                                      (e.fIrstDateTime! <=
                                          functions.currentDate(
                                              getCurrentTimestamp)) &&
                                      (e.lastDateTime! >=
                                          functions.currentDate(getCurrentTimestamp)) &&
                                      (functions.todayTime(e.time) >= getCurrentTimestamp))
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
                                      (e.date == functions.getDate(getCurrentTimestamp)) &&
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
                                  .where((e) =>
                                      (e.frequency == 'Weekly') &&
                                      (e.day ==
                                          functions.getDayofWeek(
                                              getCurrentTimestamp)) &&
                                      (e.fIrstDateTime! <=
                                          functions.currentDate(
                                              getCurrentTimestamp)) &&
                                      (e.lastDateTime! >=
                                          functions.currentDate(getCurrentTimestamp)) &&
                                      (e.timeDT! >= functions.commonTimeDT(getCurrentTimestamp)))
                                  .toList(),
                              _model.allReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(getCurrentTimestamp)) && (e.lastDateTime! >= functions.currentDate(getCurrentTimestamp)) && (functions.todayTime(e.time) >= getCurrentTimestamp)).toList())!
                          .toList()
                          .cast<RemindersRecord>();
                      _model.listOfTakenTimes = _model.todaySubReminders!
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
                      _model.takenReminders = _model.todaySubReminders!
                          .where((e) =>
                              (e.status == 'Taken') &&
                              (functions.todayTime(e.time) <
                                  getCurrentTimestamp))
                          .toList()
                          .cast<IndividualRemindersRecord>();
                      _model.listOfMissedTimes = _model.todaySubReminders!
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
                      _model.missedReminders = _model.todaySubReminders!
                          .where((e) =>
                              (e.status == 'Missed') &&
                              (functions.todayTime(e.time) <
                                  getCurrentTimestamp))
                          .toList()
                          .cast<IndividualRemindersRecord>();
                      setState(() {});
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
                                  isEqualTo: 'date',
                                ),
                      );
                      _model.listOfUpcomingTimes = functions
                          .combineTimeLists(
                              _model.calendarReminders!
                                  .where((e) =>
                                      (e.date == functions.getDate(_model.calendarSelectedDay!.start)) &&
                                      (_model.calendarSelectedDay!.start >=
                                          functions.currentDate(
                                              getCurrentTimestamp)))
                                  .toList()
                                  .map((e) => e.time)
                                  .toList(),
                              _model.calendarReminders!
                                  .where((e) =>
                                      (e.frequency == 'Daily') &&
                                      (_model.calendarSelectedDay!.start >=
                                          functions.currentDate(
                                              getCurrentTimestamp)) &&
                                      (e.fIrstDateTime! <=
                                          functions.currentDate(_model
                                              .calendarSelectedDay!.start)) &&
                                      (e.lastDateTime! >=
                                          functions.currentDate(
                                              _model.calendarSelectedDay!.start)))
                                  .toList()
                                  .map((e) => e.time)
                                  .toList(),
                              _model.calendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay!.start)) && (_model.calendarSelectedDay!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay!.start))).toList().map((e) => e.time).toList(),
                              _model.calendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay!.start)) && (_model.calendarSelectedDay!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay!.start))).toList().map((e) => e.time).toList())!
                          .sortedList(keyOf: (e) => e, desc: false)
                          .unique((e) => e)
                          .toList()
                          .cast<String>();
                      _model.upcomingReminders = functions
                          .combineReminderLists(
                              _model.calendarReminders!
                                  .where((e) =>
                                      (e.date == functions.getDate(_model.calendarSelectedDay!.start)) &&
                                      (_model.calendarSelectedDay!.start >=
                                          functions.currentDate(
                                              getCurrentTimestamp)))
                                  .toList(),
                              _model.calendarReminders!
                                  .where((e) =>
                                      (e.frequency == 'Daily') &&
                                      (_model.calendarSelectedDay!.start >=
                                          functions.currentDate(
                                              getCurrentTimestamp)) &&
                                      (e.fIrstDateTime! <=
                                          functions.currentDate(_model
                                              .calendarSelectedDay!.start)) &&
                                      (e.lastDateTime! >=
                                          functions.currentDate(
                                              _model.calendarSelectedDay!.start)))
                                  .toList(),
                              _model.calendarReminders!.where((e) => (e.frequency == 'Weekly') && (e.day == functions.getDayofWeek(_model.calendarSelectedDay!.start)) && (_model.calendarSelectedDay!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay!.start))).toList(),
                              _model.calendarReminders!.where((e) => (e.frequency == 'Monthly') && (e.dateNumber == functions.extractDayNumber(_model.calendarSelectedDay!.start)) && (_model.calendarSelectedDay!.start >= functions.currentDate(getCurrentTimestamp)) && (e.fIrstDateTime! <= functions.currentDate(_model.calendarSelectedDay!.start)) && (e.lastDateTime! >= functions.currentDate(_model.calendarSelectedDay!.start))).toList())!
                          .toList()
                          .cast<RemindersRecord>();
                      _model.listOfTakenTimes = _model.calendarSubReminders!
                          .where((e) =>
                              (e.status == 'Taken') &&
                              (_model.calendarSelectedDay!.start <
                                  functions.currentDate(getCurrentTimestamp)))
                          .toList()
                          .map((e) => e.time)
                          .toList()
                          .unique((e) => e)
                          .sortedList(keyOf: (e) => e, desc: false)
                          .toList()
                          .cast<String>();
                      _model.takenReminders = _model.calendarSubReminders!
                          .where((e) =>
                              (e.status == 'Taken') &&
                              (_model.calendarSelectedDay!.start <
                                  functions.currentDate(getCurrentTimestamp)))
                          .toList()
                          .cast<IndividualRemindersRecord>();
                      _model.listOfMissedTimes = _model.calendarSubReminders!
                          .where((e) =>
                              (e.status == 'Missed') &&
                              (_model.calendarSelectedDay!.start <
                                  functions.currentDate(getCurrentTimestamp)))
                          .toList()
                          .map((e) => e.time)
                          .toList()
                          .unique((e) => e)
                          .sortedList(keyOf: (e) => e, desc: false)
                          .toList()
                          .cast<String>();
                      _model.missedReminders = _model.calendarSubReminders!
                          .where((e) =>
                              (e.status == 'Missed') &&
                              (_model.calendarSelectedDay!.start <
                                  functions.currentDate(getCurrentTimestamp)))
                          .toList()
                          .cast<IndividualRemindersRecord>();
                      setState(() {});
                    }

                    setState(() {});
                  },
                  titleStyle:
                      FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                  dayOfWeekStyle:
                      FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                  dateStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                  selectedDateStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                  inactiveDateStyle:
                      FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if ((_model.listOfUpcomingTimes.isNotEmpty) == true)
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Upcoming Reminders',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Builder(
                                builder: (context) {
                                  final generatingTimeList =
                                      _model.listOfUpcomingTimes.toList();
                                  if (generatingTimeList.isEmpty) {
                                    return const Center(
                                      child: NoElementsWidget(
                                        additionalText:
                                            'Add one by pressing \'\'Add reminder\"  below',
                                      ),
                                    );
                                  }

                                  return ListView.separated(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: generatingTimeList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 5.0),
                                    itemBuilder:
                                        (context, generatingTimeListIndex) {
                                      final generatingTimeListItem =
                                          generatingTimeList[
                                              generatingTimeListIndex];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    generatingTimeListItem,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final specificTimeReminderList =
                                                        _model.upcomingReminders
                                                            .where((e) =>
                                                                e.time ==
                                                                generatingTimeListItem)
                                                            .toList();

                                                    return ListView.builder(
                                                      padding: EdgeInsets.zero,
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
                                                              setState(() {}),
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
                            ],
                          ),
                        if ((_model.takenReminders.isNotEmpty) == true)
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Taken Reminders',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Builder(
                                builder: (context) {
                                  final takenTimeList =
                                      _model.listOfTakenTimes.toList();
                                  if (takenTimeList.isEmpty) {
                                    return const Center(
                                      child: NoElementsWidget(
                                        additionalText:
                                            'Add one by pressing \'\'Add reminder\"  below',
                                      ),
                                    );
                                  }

                                  return ListView.separated(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: takenTimeList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 5.0),
                                    itemBuilder: (context, takenTimeListIndex) {
                                      final takenTimeListItem =
                                          takenTimeList[takenTimeListIndex];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    takenTimeListItem,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final takenReminderList =
                                                        _model
                                                            .takenReminders
                                                            .where((e) =>
                                                                e.time ==
                                                                takenTimeListItem)
                                                            .toList();

                                                    return ListView.builder(
                                                      padding: EdgeInsets.zero,
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
                            ],
                          ),
                        if ((_model.missedReminders.isNotEmpty) == true)
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Missed Reminders',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Builder(
                                builder: (context) {
                                  final missedTimeList =
                                      _model.listOfMissedTimes.toList();
                                  if (missedTimeList.isEmpty) {
                                    return const Center(
                                      child: NoElementsWidget(
                                        additionalText:
                                            'Add one by pressing \'\'Add reminder\"  below',
                                      ),
                                    );
                                  }

                                  return ListView.separated(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: missedTimeList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 5.0),
                                    itemBuilder:
                                        (context, missedTimeListIndex) {
                                      final missedTimeListItem =
                                          missedTimeList[missedTimeListIndex];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    missedTimeListItem,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                      padding: EdgeInsets.zero,
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
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'MedicationList',
                                    queryParameters: {
                                      'addReminder': serializeParam(
                                        true,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text: 'Add Reminder',
                                icon: const Icon(
                                  Icons.add_alert,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
