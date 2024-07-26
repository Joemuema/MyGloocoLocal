import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/medication/med_list_item/med_list_item_widget.dart';
import '/medication/medicine_description/medicine_description_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'medication_list_model.dart';
export 'medication_list_model.dart';

class MedicationListWidget extends StatefulWidget {
  const MedicationListWidget({
    super.key,
    bool? addReminder,
  }) : addReminder = addReminder ?? false;

  final bool addReminder;

  @override
  State<MedicationListWidget> createState() => _MedicationListWidgetState();
}

class _MedicationListWidgetState extends State<MedicationListWidget> {
  late MedicationListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedicationListModel());

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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Medication List',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
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
                if (widget.addReminder)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Choose medicine to add reminder for',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    width: double.infinity,
                    height: 50.0,
                    constraints: const BoxConstraints(
                      maxWidth: 430.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Pills',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  content: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 430.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: StreamBuilder<List<MedicineRecord>>(
                        stream: queryMedicineRecord(
                          queryBuilder: (medicineRecord) => medicineRecord
                              .where(
                                'UserID',
                                isEqualTo: FFAppState().UserID,
                              )
                              .where(
                                'Form',
                                isEqualTo: valueOrDefault<String>(
                                  'Pill',
                                  'Pill',
                                ),
                              )
                              .orderBy('Name'),
                        ),
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
                          List<MedicineRecord> pillsListViewMedicineRecordList =
                              snapshot.data!;
                          if (pillsListViewMedicineRecordList.isEmpty) {
                            return const NoElementsWidget(
                              additionalText: 'Add new pills to display here',
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: pillsListViewMedicineRecordList.length,
                            itemBuilder: (context, pillsListViewIndex) {
                              final pillsListViewMedicineRecord =
                                  pillsListViewMedicineRecordList[
                                      pillsListViewIndex];
                              return Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (widget.addReminder) {
                                        if (Navigator.of(context).canPop()) {
                                          context.pop();
                                        }
                                        context.pushNamed(
                                          'MedicationForm',
                                          queryParameters: {
                                            'newMedicineID': serializeParam(
                                              pillsListViewMedicineRecord
                                                  .reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'editMode': serializeParam(
                                              true,
                                              ParamType.bool,
                                            ),
                                            'addReminder': serializeParam(
                                              true,
                                              ParamType.bool,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        _model.pillReminderList =
                                            await queryRemindersRecordOnce(
                                          queryBuilder: (remindersRecord) =>
                                              remindersRecord
                                                  .where(
                                                    'UserID',
                                                    isEqualTo:
                                                        FFAppState().UserID,
                                                  )
                                                  .where(
                                                    'MedicineID',
                                                    isEqualTo:
                                                        pillsListViewMedicineRecord
                                                            .reference,
                                                  )
                                                  .orderBy('Time'),
                                        );
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () => _model.unfocusNode
                                                      .canRequestFocus
                                                  ? FocusScope.of(context)
                                                      .requestFocus(
                                                          _model.unfocusNode)
                                                  : FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child:
                                                    MedicineDescriptionWidget(
                                                  medDocRef:
                                                      pillsListViewMedicineRecord,
                                                  reminderMedRefs:
                                                      _model.pillReminderList!,
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      }

                                      setState(() {});
                                    },
                                    child: wrapWithModel(
                                      model: _model.medListItemModels1.getModel(
                                        pillsListViewMedicineRecord
                                            .reference.id,
                                        pillsListViewIndex,
                                      ),
                                      updateCallback: () => setState(() {}),
                                      child: MedListItemWidget(
                                        key: Key(
                                          'Keyz90_${pillsListViewMedicineRecord.reference.id}',
                                        ),
                                        medItem: pillsListViewMedicineRecord,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    width: double.infinity,
                    height: 50.0,
                    constraints: const BoxConstraints(
                      maxWidth: 430.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Tablets',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  content: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 430.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: StreamBuilder<List<MedicineRecord>>(
                        stream: queryMedicineRecord(
                          queryBuilder: (medicineRecord) => medicineRecord
                              .where(
                                'UserID',
                                isEqualTo: FFAppState().UserID,
                              )
                              .where(
                                'Form',
                                isEqualTo: valueOrDefault<String>(
                                  'Tablet',
                                  'Tablet',
                                ),
                              )
                              .orderBy('Name'),
                        ),
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
                          List<MedicineRecord>
                              tabletsListViewMedicineRecordList =
                              snapshot.data!;
                          if (tabletsListViewMedicineRecordList.isEmpty) {
                            return const NoElementsWidget(
                              additionalText: 'Add new tablets to display here',
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: tabletsListViewMedicineRecordList.length,
                            itemBuilder: (context, tabletsListViewIndex) {
                              final tabletsListViewMedicineRecord =
                                  tabletsListViewMedicineRecordList[
                                      tabletsListViewIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (widget.addReminder) {
                                      if (Navigator.of(context).canPop()) {
                                        context.pop();
                                      }
                                      context.pushNamed(
                                        'MedicationForm',
                                        queryParameters: {
                                          'newMedicineID': serializeParam(
                                            tabletsListViewMedicineRecord
                                                .reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'editMode': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                          'addReminder': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                        }.withoutNulls,
                                      );
                                    } else {
                                      _model.tabletReminderList =
                                          await queryRemindersRecordOnce(
                                        queryBuilder: (remindersRecord) =>
                                            remindersRecord
                                                .where(
                                                  'UserID',
                                                  isEqualTo:
                                                      FFAppState().UserID,
                                                )
                                                .where(
                                                  'MedicineID',
                                                  isEqualTo:
                                                      tabletsListViewMedicineRecord
                                                          .reference,
                                                )
                                                .orderBy('Time'),
                                      );
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: MedicineDescriptionWidget(
                                                medDocRef:
                                                    tabletsListViewMedicineRecord,
                                                reminderMedRefs:
                                                    _model.tabletReminderList!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    }

                                    setState(() {});
                                  },
                                  child: MedListItemWidget(
                                    key: Key(
                                        'Key70w_${tabletsListViewIndex}_of_${tabletsListViewMedicineRecordList.length}'),
                                    medItem: tabletsListViewMedicineRecord,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    width: double.infinity,
                    height: 50.0,
                    constraints: const BoxConstraints(
                      maxWidth: 430.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Emulsions',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  content: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 430.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: StreamBuilder<List<MedicineRecord>>(
                        stream: queryMedicineRecord(
                          queryBuilder: (medicineRecord) => medicineRecord
                              .where(
                                'UserID',
                                isEqualTo: FFAppState().UserID,
                              )
                              .where(
                                'Form',
                                isEqualTo: valueOrDefault<String>(
                                  'Emulsion',
                                  'Emulsion',
                                ),
                              )
                              .orderBy('Name'),
                        ),
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
                          List<MedicineRecord>
                              emulsionListViewMedicineRecordList =
                              snapshot.data!;
                          if (emulsionListViewMedicineRecordList.isEmpty) {
                            return const NoElementsWidget(
                              additionalText:
                                  'Add new emulsions to display here',
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                emulsionListViewMedicineRecordList.length,
                            itemBuilder: (context, emulsionListViewIndex) {
                              final emulsionListViewMedicineRecord =
                                  emulsionListViewMedicineRecordList[
                                      emulsionListViewIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (widget.addReminder) {
                                      if (Navigator.of(context).canPop()) {
                                        context.pop();
                                      }
                                      context.pushNamed(
                                        'MedicationForm',
                                        queryParameters: {
                                          'newMedicineID': serializeParam(
                                            emulsionListViewMedicineRecord
                                                .reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'editMode': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                          'addReminder': serializeParam(
                                            true,
                                            ParamType.bool,
                                          ),
                                        }.withoutNulls,
                                      );
                                    } else {
                                      _model.emulsionReminderList =
                                          await queryRemindersRecordOnce(
                                        queryBuilder: (remindersRecord) =>
                                            remindersRecord
                                                .where(
                                                  'UserID',
                                                  isEqualTo:
                                                      FFAppState().UserID,
                                                )
                                                .where(
                                                  'MedicineID',
                                                  isEqualTo:
                                                      emulsionListViewMedicineRecord
                                                          .reference,
                                                )
                                                .orderBy('Time'),
                                      );
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: MedicineDescriptionWidget(
                                                medDocRef:
                                                    emulsionListViewMedicineRecord,
                                                reminderMedRefs: _model
                                                    .emulsionReminderList!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    }

                                    setState(() {});
                                  },
                                  child: MedListItemWidget(
                                    key: Key(
                                        'Keyj44_${emulsionListViewIndex}_of_${emulsionListViewMedicineRecordList.length}'),
                                    medItem: emulsionListViewMedicineRecord,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 400.0),
                  child: StickyHeader(
                    overlapHeaders: false,
                    header: Container(
                      width: double.infinity,
                      height: 50.0,
                      constraints: const BoxConstraints(
                        maxWidth: 430.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Injections',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                    content: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        maxWidth: 430.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: StreamBuilder<List<MedicineRecord>>(
                          stream: queryMedicineRecord(
                            queryBuilder: (medicineRecord) => medicineRecord
                                .where(
                                  'UserID',
                                  isEqualTo: FFAppState().UserID,
                                )
                                .where(
                                  'Form',
                                  isEqualTo: valueOrDefault<String>(
                                    'Injection',
                                    'Injection',
                                  ),
                                )
                                .orderBy('Name'),
                          ),
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
                            List<MedicineRecord>
                                injectionListViewMedicineRecordList =
                                snapshot.data!;
                            if (injectionListViewMedicineRecordList.isEmpty) {
                              return const NoElementsWidget(
                                additionalText:
                                    'Add new injections to display here',
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  injectionListViewMedicineRecordList.length,
                              itemBuilder: (context, injectionListViewIndex) {
                                final injectionListViewMedicineRecord =
                                    injectionListViewMedicineRecordList[
                                        injectionListViewIndex];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (widget.addReminder) {
                                        if (Navigator.of(context).canPop()) {
                                          context.pop();
                                        }
                                        context.pushNamed(
                                          'MedicationForm',
                                          queryParameters: {
                                            'newMedicineID': serializeParam(
                                              injectionListViewMedicineRecord
                                                  .reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'editMode': serializeParam(
                                              true,
                                              ParamType.bool,
                                            ),
                                            'addReminder': serializeParam(
                                              true,
                                              ParamType.bool,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        _model.injectionReminderList =
                                            await queryRemindersRecordOnce(
                                          queryBuilder: (remindersRecord) =>
                                              remindersRecord
                                                  .where(
                                                    'UserID',
                                                    isEqualTo:
                                                        FFAppState().UserID,
                                                  )
                                                  .where(
                                                    'MedicineID',
                                                    isEqualTo:
                                                        injectionListViewMedicineRecord
                                                            .reference,
                                                  )
                                                  .orderBy('Time'),
                                        );
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () => _model.unfocusNode
                                                      .canRequestFocus
                                                  ? FocusScope.of(context)
                                                      .requestFocus(
                                                          _model.unfocusNode)
                                                  : FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child:
                                                    MedicineDescriptionWidget(
                                                  medDocRef:
                                                      injectionListViewMedicineRecord,
                                                  reminderMedRefs: _model
                                                      .injectionReminderList!,
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      }

                                      setState(() {});
                                    },
                                    child: MedListItemWidget(
                                      key: Key(
                                          'Keyo1s_${injectionListViewIndex}_of_${injectionListViewMedicineRecordList.length}'),
                                      medItem: injectionListViewMedicineRecord,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
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
