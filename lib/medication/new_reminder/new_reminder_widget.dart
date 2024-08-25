import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/medication/edit_reminder_name/edit_reminder_name_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'new_reminder_model.dart';
export 'new_reminder_model.dart';

class NewReminderWidget extends StatefulWidget {
  const NewReminderWidget({
    super.key,
    this.currentReminderID,
    this.deleteFromList,
    bool? editState,
    this.index,
    this.reminderName,
    this.addToList,
    this.remIDList,
  }) : editState = editState ?? false;

  final DocumentReference? currentReminderID;
  final Future Function()? deleteFromList;
  final bool editState;
  final int? index;
  final String? reminderName;
  final Future Function()? addToList;
  final List<DocumentReference>? remIDList;

  @override
  State<NewReminderWidget> createState() => _NewReminderWidgetState();
}

class _NewReminderWidgetState extends State<NewReminderWidget> {
  late NewReminderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewReminderModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currentReminderName =
          widget.reminderName != null && widget.reminderName != ''
              ? widget.reminderName!
              : 'Reminder ${((widget.index!) + 1).toString()}';
      setState(() {});

      await widget.currentReminderID!.update(createRemindersRecordData(
        name: _model.currentReminderName,
      ));
    });

    _model.dateFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _model.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
        child: StreamBuilder<RemindersRecord>(
          stream: RemindersRecord.getDocument(widget.currentReminderID!),
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
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: FlutterFlowTheme.of(context).boxShadowColor,
                    offset: const Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 0.0, 0.0),
                                child: Text(
                                  containerRemindersRecord.name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    7.0, 13.0, 0.0, 0.0),
                                child: InkWell(
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
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: EditReminderNameWidget(
                                            reminderNameID:
                                                widget.currentReminderID!,
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.reminderName = value));

                                    setState(() {});
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.edit,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 30.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await widget.deleteFromList?.call();
                              await actions.deleteIndividualReminders(
                                widget.currentReminderID!,
                              );
                            },
                            child: Icon(
                              Icons.delete_rounded,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    30.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Auto-Remind',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.61,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      30.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Automatically reminds you regularly',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 30.0, 0.0),
                            child: Switch.adaptive(
                              value: _model.switchValue1 ??= widget.editState
                                  ? containerRemindersRecord.autoSet
                                  : false,
                              onChanged: (newValue) async {
                                setState(() => _model.switchValue1 = newValue);
                                if (newValue) {
                                  await widget.currentReminderID!
                                      .update(createRemindersRecordData(
                                    autoSet: true,
                                    date: '',
                                    time: '',
                                  ));
                                } else {
                                  await widget.currentReminderID!
                                      .update(createRemindersRecordData(
                                    autoSet: false,
                                    frequency: '',
                                    day: '',
                                    dateNumber: null,
                                    time: '',
                                  ));
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
                        ],
                      ),
                    ),
                    if (_model.switchValue1 ?? true)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        30.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Frequency',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        30.0, 10.0, 30.0, 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: FlutterFlowTheme.of(context)
                                                .boxShadowColor,
                                            offset: const Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: FlutterFlowDropDown<String>(
                                        controller:
                                            _model.frequencyValueController ??=
                                                FormFieldController<String>(
                                          _model.frequencyValue ??=
                                              containerRemindersRecord
                                                  .frequency,
                                        ),
                                        options: const ['Daily', 'Weekly', 'Monthly'],
                                        onChanged: (val) async {
                                          setState(() =>
                                              _model.frequencyValue = val);
                                          if (widget.editState == true) {
                                            if (widget.remIDList?.contains(
                                                    widget
                                                        .currentReminderID) !=
                                                true) {
                                              await widget.addToList?.call();
                                            }
                                          }

                                          await widget.currentReminderID!
                                              .update(createRemindersRecordData(
                                            frequency: _model.frequencyValue,
                                          ));
                                        },
                                        height: 56.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: 'How regular',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 2.0,
                                        borderRadius: 12.0,
                                        margin: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 16.0, 4.0),
                                        hidesUnderline: true,
                                        isOverButton: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                        labelText: '',
                                        labelTextStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                      ),
                                    ),
                                  ),
                                  if (_model.frequencyValue == 'Weekly')
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    30.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Day of week:',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      30.0, 0.0, 30.0, 0.0),
                                              child: Container(
                                                width: 168.0,
                                                height: 56.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .boxShadowColor,
                                                      offset: const Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child:
                                                    FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .weekDayListValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.weekDayListValue ??=
                                                        containerRemindersRecord
                                                            .day,
                                                  ),
                                                  options: const [
                                                    'Monday',
                                                    'Tuesday',
                                                    'Wednesday',
                                                    'Thursday',
                                                    'Friday',
                                                    'Saturday',
                                                    'Sunday'
                                                  ],
                                                  onChanged: (val) async {
                                                    setState(() => _model
                                                            .weekDayListValue =
                                                        val);
                                                    if (widget.editState ==
                                                        true) {
                                                      if (widget.remIDList
                                                              ?.contains(widget
                                                                  .currentReminderID) !=
                                                          true) {
                                                        await widget.addToList
                                                            ?.call();
                                                      }
                                                    }

                                                    await widget
                                                        .currentReminderID!
                                                        .update(
                                                            createRemindersRecordData(
                                                      day: _model
                                                          .weekDayListValue,
                                                    ));
                                                  },
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintText: 'Choose Day',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderWidth: 2.0,
                                                  borderRadius: 12.0,
                                                  margin: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 4.0, 16.0, 4.0),
                                                  hidesUnderline: true,
                                                  isOverButton: true,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                  labelText: '',
                                                  labelTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (_model.frequencyValue == 'Monthly')
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    30.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Date:',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      30.0, 0.0, 30.0, 0.0),
                                              child: Container(
                                                width: 168.0,
                                                height: 56.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .boxShadowColor,
                                                      offset: const Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: TextFormField(
                                                    controller: _model
                                                            .dateFieldTextController ??=
                                                        TextEditingController(
                                                      text:
                                                          containerRemindersRecord
                                                              .dateNumber
                                                              .toString(),
                                                    ),
                                                    focusNode: _model
                                                        .dateFieldFocusNode,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.dateFieldTextController',
                                                      const Duration(
                                                          milliseconds: 2000),
                                                      () async {
                                                        await widget
                                                            .currentReminderID!
                                                            .update(
                                                                createRemindersRecordData(
                                                          dateNumber: int
                                                              .tryParse(_model
                                                                  .dateFieldTextController
                                                                  .text),
                                                        ));
                                                      },
                                                    ),
                                                    onFieldSubmitted:
                                                        (_) async {
                                                      if (widget.editState ==
                                                          true) {
                                                        if (widget.remIDList
                                                                ?.contains(widget
                                                                    .currentReminderID) !=
                                                            true) {
                                                          await widget.addToList
                                                              ?.call();
                                                        }
                                                      }

                                                      await widget
                                                          .currentReminderID!
                                                          .update(
                                                              createRemindersRecordData(
                                                        autoSet: true,
                                                      ));
                                                    },
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      hintText: 'Calendar date',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: _model
                                                        .dateFieldTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  30.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            'Time:',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    30.0, 0.0, 30.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                final datePicked1Time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          getCurrentTimestamp),
                                                  builder: (context, child) {
                                                    return wrapInMaterialTimePickerTheme(
                                                      context,
                                                      child!,
                                                      headerBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      headerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      headerTextStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 32.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                      pickerBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      pickerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      selectedDateTimeBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      selectedDateTimeForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      actionButtonForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      iconSize: 24.0,
                                                    );
                                                  },
                                                );
                                                if (datePicked1Time != null) {
                                                  safeSetState(() {
                                                    _model.datePicked1 =
                                                        DateTime(
                                                      getCurrentTimestamp.year,
                                                      getCurrentTimestamp.month,
                                                      getCurrentTimestamp.day,
                                                      datePicked1Time.hour,
                                                      datePicked1Time.minute,
                                                    );
                                                  });
                                                }
                                                if (widget.editState == true) {
                                                  if (widget.remIDList
                                                          ?.contains(widget
                                                              .currentReminderID) !=
                                                      true) {
                                                    await widget.addToList
                                                        ?.call();
                                                  }
                                                }

                                                await widget.currentReminderID!
                                                    .update(
                                                        createRemindersRecordData(
                                                  time: functions.getTime(
                                                      _model.datePicked1!),
                                                  timeDT:
                                                      functions.commonTimeDT(
                                                          getCurrentTimestamp),
                                                ));
                                              },
                                              text: valueOrDefault<String>(
                                                widget.editState
                                                    ? (containerRemindersRecord
                                                                    .time !=
                                                                ''
                                                        ? containerRemindersRecord
                                                            .time
                                                        : (_model.datePicked1 !=
                                                                null
                                                            ? functions.getTime(
                                                                _model
                                                                    .datePicked1!)
                                                            : ''))
                                                    : (_model.datePicked1 !=
                                                            null
                                                        ? functions.getTime(
                                                            _model.datePicked1!)
                                                        : ''),
                                                'Choose Time',
                                              ),
                                              options: FFButtonOptions(
                                                width: 168.0,
                                                height: 40.0,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                                elevation: 3.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      30.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Custom date range',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.61,
                                              decoration: const BoxDecoration(),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        30.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Set specific start and end dates for this reminder',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 30.0, 0.0),
                                          child: Switch.adaptive(
                                            value: _model.switchValue2 ??=
                                                widget.editState
                                                    ? containerRemindersRecord
                                                        .setCustomDates
                                                    : false,
                                            onChanged: (newValue) async {
                                              setState(() => _model
                                                  .switchValue2 = newValue);
                                              if (newValue) {
                                                await widget.currentReminderID!
                                                    .update(
                                                        createRemindersRecordData(
                                                  setCustomDates: true,
                                                ));
                                              } else {
                                                await widget.currentReminderID!
                                                    .update(
                                                        createRemindersRecordData(
                                                  setCustomDates: false,
                                                ));
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            activeTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent1,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            inactiveThumbColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_model.switchValue2 ?? true)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 10.0, 16.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        3.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Start Date',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 10.0, 5.0, 10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        final datePicked2Date =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              getCurrentTimestamp,
                                                          firstDate:
                                                              getCurrentTimestamp,
                                                          lastDate:
                                                              DateTime(2050),
                                                          builder:
                                                              (context, child) {
                                                            return wrapInMaterialDatePickerTheme(
                                                              context,
                                                              child!,
                                                              headerBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              headerForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                              headerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            32.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                              pickerBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              pickerForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              selectedDateTimeBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              selectedDateTimeForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                              actionButtonForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              iconSize: 24.0,
                                                            );
                                                          },
                                                        );

                                                        if (datePicked2Date !=
                                                            null) {
                                                          safeSetState(() {
                                                            _model.datePicked2 =
                                                                DateTime(
                                                              datePicked2Date
                                                                  .year,
                                                              datePicked2Date
                                                                  .month,
                                                              datePicked2Date
                                                                  .day,
                                                            );
                                                          });
                                                        }
                                                        if (widget.editState ==
                                                            true) {
                                                          if (widget.remIDList
                                                                  ?.contains(widget
                                                                      .currentReminderID) !=
                                                              true) {
                                                            await widget
                                                                .addToList
                                                                ?.call();
                                                          }
                                                        }

                                                        await widget
                                                            .currentReminderID!
                                                            .update(
                                                                createRemindersRecordData(
                                                          firstDate: functions
                                                              .getDate(_model
                                                                  .datePicked2!),
                                                          fIrstDateTime: _model
                                                              .datePicked2,
                                                          lastUpdated: _model
                                                              .datePicked2,
                                                        ));
                                                      },
                                                      text: valueOrDefault<
                                                          String>(
                                                        widget.editState
                                                            ? (_model.datePicked2 !=
                                                                    null
                                                                ? functions
                                                                    .getDate(_model
                                                                        .datePicked2!)
                                                                : containerRemindersRecord
                                                                    .firstDate)
                                                            : (_model.datePicked2 !=
                                                                    null
                                                                ? functions
                                                                    .getDate(_model
                                                                        .datePicked2!)
                                                                : ''),
                                                        'Choose Date',
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0,
                                                                    0.0,
                                                                    24.0,
                                                                    0.0),
                                                        iconPadding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 3.0,
                                                        borderSide: const BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        3.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Finish Date',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 5.0, 10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          final datePicked3Date =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                getCurrentTimestamp,
                                                            firstDate:
                                                                getCurrentTimestamp,
                                                            lastDate:
                                                                DateTime(2050),
                                                            builder: (context,
                                                                child) {
                                                              return wrapInMaterialDatePickerTheme(
                                                                context,
                                                                child!,
                                                                headerBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                headerForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                headerTextStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontSize:
                                                                              32.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                pickerBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                pickerForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                selectedDateTimeBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                selectedDateTimeForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                actionButtonForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                iconSize: 24.0,
                                                              );
                                                            },
                                                          );

                                                          if (datePicked3Date !=
                                                              null) {
                                                            safeSetState(() {
                                                              _model.datePicked3 =
                                                                  DateTime(
                                                                datePicked3Date
                                                                    .year,
                                                                datePicked3Date
                                                                    .month,
                                                                datePicked3Date
                                                                    .day,
                                                              );
                                                            });
                                                          }
                                                          if (widget
                                                                  .editState ==
                                                              true) {
                                                            if (widget
                                                                    .remIDList
                                                                    ?.contains(
                                                                        widget
                                                                            .currentReminderID) !=
                                                                true) {
                                                              await widget
                                                                  .addToList
                                                                  ?.call();
                                                            }
                                                          }

                                                          await widget
                                                              .currentReminderID!
                                                              .update(
                                                                  createRemindersRecordData(
                                                            lastDate: () {
                                                              if (containerRemindersRecord
                                                                      .frequency ==
                                                                  'Weekly') {
                                                                return functions.setWeeklyLastDate(
                                                                    functions.getDate(
                                                                        _model
                                                                            .datePicked3!),
                                                                    containerRemindersRecord
                                                                        .day);
                                                              } else if (containerRemindersRecord
                                                                      .frequency ==
                                                                  'Monthly') {
                                                                return functions.setMonthlyLastDate(
                                                                    functions.getDate(
                                                                        _model
                                                                            .datePicked3!),
                                                                    containerRemindersRecord
                                                                        .dateNumber);
                                                              } else {
                                                                return functions
                                                                    .getDate(_model
                                                                        .datePicked3!);
                                                              }
                                                            }(),
                                                            lastDateTime:
                                                                functions
                                                                    .stringToDate(
                                                                        () {
                                                              if (containerRemindersRecord
                                                                      .frequency ==
                                                                  'Weekly') {
                                                                return functions.setWeeklyLastDate(
                                                                    functions.getDate(
                                                                        _model
                                                                            .datePicked3!),
                                                                    containerRemindersRecord
                                                                        .day);
                                                              } else if (containerRemindersRecord
                                                                      .frequency ==
                                                                  'Monthly') {
                                                                return functions.setMonthlyLastDate(
                                                                    functions.getDate(
                                                                        _model
                                                                            .datePicked3!),
                                                                    containerRemindersRecord
                                                                        .dateNumber);
                                                              } else {
                                                                return functions
                                                                    .getDate(_model
                                                                        .datePicked3!);
                                                              }
                                                            }()),
                                                          ));
                                                        },
                                                        text: valueOrDefault<
                                                            String>(
                                                          widget.editState
                                                              ? (_model.datePicked3 !=
                                                                      null
                                                                  ? functions
                                                                      .getDate(
                                                                          _model
                                                                              .datePicked3!)
                                                                  : containerRemindersRecord
                                                                      .lastDate)
                                                              : (_model.datePicked3 !=
                                                                      null
                                                                  ? functions
                                                                      .getDate(
                                                                          _model
                                                                              .datePicked3!)
                                                                  : ''),
                                                          'Choose Date',
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24.0,
                                                                      0.0,
                                                                      24.0,
                                                                      0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                    if (!_model.switchValue1!)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 10.0, 10.0, 15.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                final datePicked4Date = await showDatePicker(
                                  context: context,
                                  initialDate: getCurrentTimestamp,
                                  firstDate: getCurrentTimestamp,
                                  lastDate: DateTime(2050),
                                  builder: (context, child) {
                                    return wrapInMaterialDatePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .headlineLarge
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 32.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                      pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );

                                if (datePicked4Date != null) {
                                  safeSetState(() {
                                    _model.datePicked4 = DateTime(
                                      datePicked4Date.year,
                                      datePicked4Date.month,
                                      datePicked4Date.day,
                                    );
                                  });
                                }
                                if (widget.editState == true) {
                                  if (widget.remIDList?.contains(
                                          widget.currentReminderID) !=
                                      true) {
                                    await widget.addToList?.call();
                                  }
                                }

                                await widget.currentReminderID!
                                    .update(createRemindersRecordData(
                                  date: functions.getDate(_model.datePicked4!),
                                ));
                              },
                              text: valueOrDefault<String>(
                                widget.editState
                                    ? (containerRemindersRecord.date != 'None'
                                        ? containerRemindersRecord.date
                                        : (_model.datePicked4 != null
                                            ? functions
                                                .getDate(_model.datePicked4!)
                                            : ''))
                                    : (_model.datePicked4 != null
                                        ? functions.getDate(_model.datePicked4!)
                                        : ''),
                                'Choose Date',
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 30.0, 15.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                final datePicked5Time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      getCurrentTimestamp),
                                  builder: (context, child) {
                                    return wrapInMaterialTimePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .headlineLarge
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 32.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                      pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );
                                if (datePicked5Time != null) {
                                  safeSetState(() {
                                    _model.datePicked5 = DateTime(
                                      getCurrentTimestamp.year,
                                      getCurrentTimestamp.month,
                                      getCurrentTimestamp.day,
                                      datePicked5Time.hour,
                                      datePicked5Time.minute,
                                    );
                                  });
                                }
                                if (widget.editState == true) {
                                  if (widget.remIDList?.contains(
                                          widget.currentReminderID) !=
                                      true) {
                                    await widget.addToList?.call();
                                  }
                                }

                                await widget.currentReminderID!
                                    .update(createRemindersRecordData(
                                  time: functions.getTime(_model.datePicked5!),
                                ));
                              },
                              text: valueOrDefault<String>(
                                widget.editState
                                    ? (containerRemindersRecord.time != ''
                                        ? containerRemindersRecord.time
                                        : (_model.datePicked5 != null
                                            ? functions
                                                .getTime(_model.datePicked5!)
                                            : ''))
                                    : (_model.datePicked5 != null
                                        ? functions.getTime(_model.datePicked5!)
                                        : ''),
                                'Choose Time',
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
