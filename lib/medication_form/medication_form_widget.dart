import '/backend/backend.dart';
import '/components/new_reminder_widget.dart';
import '/components/no_elements_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'medication_form_model.dart';
export 'medication_form_model.dart';

class MedicationFormWidget extends StatefulWidget {
  const MedicationFormWidget({
    super.key,
    required this.newMedicineID,
    required this.editMode,
    bool? addReminder,
  }) : addReminder = addReminder ?? false;

  final DocumentReference? newMedicineID;
  final bool? editMode;
  final bool addReminder;

  @override
  State<MedicationFormWidget> createState() => _MedicationFormWidgetState();
}

class _MedicationFormWidgetState extends State<MedicationFormWidget> {
  late MedicationFormModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedicationFormModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.reminderIDList = [];
      setState(() {});
      await _model.mainColumn?.animateTo(
        _model.mainColumn!.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    });

    _model.medNameFocusNode ??= FocusNode();

    _model.singleDoseFocusNode ??= FocusNode();

    _model.totalDoseFocusNode ??= FocusNode();

    _model.descriptionTextFocusNode ??= FocusNode();

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

    return StreamBuilder<MedicineRecord>(
      stream: MedicineRecord.getDocument(widget.newMedicineID!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final medicationFormMedicineRecord = snapshot.data!;

        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).bTeal,
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
                  if (widget.addReminder) {
                    context.goNamed('MedicationHome');
                  } else {
                    await actions.deleteDocuments(
                      _model.reminderIDList.toList(),
                    );
                    if (!widget.editMode!) {
                      await widget.newMedicineID!.delete();
                    }
                    context.safePop();
                  }
                },
              ),
              title: Text(
                widget.addReminder
                    ? 'Add Reminder'
                    : '${widget.editMode! ? 'Edit' : 'Add'} Medication',
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
                controller: _model.mainColumn,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 20.0, 10.0, 10.0),
                      child: Container(
                        width: 364.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  3.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Medicine Name',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 10.0, 5.0, 0.0),
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
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.medNameTextController ??=
                                        TextEditingController(
                                      text: widget.editMode!
                                          ? medicationFormMedicineRecord.name
                                          : '',
                                    ),
                                    focusNode: _model.medNameFocusNode,
                                    autofocus: true,
                                    readOnly: widget.addReminder,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'Label Name',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                    validator: _model
                                        .medNameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Container(
                        width: 364.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  3.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Medicine Type',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 10.0, 5.0, 0.0),
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
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: FlutterFlowDropDown<String>(
                                  controller: _model.medTypeValueController ??=
                                      FormFieldController<String>(
                                    _model.medTypeValue ??= widget.editMode!
                                        ? medicationFormMedicineRecord.form
                                        : '',
                                  ),
                                  options: const [
                                    'Pill',
                                    'Tablet',
                                    'Emulsion',
                                    'Injection'
                                  ],
                                  onChanged: (val) =>
                                      setState(() => _model.medTypeValue = val),
                                  width: 357.0,
                                  height: 56.0,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Select Type',
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
                                  disabled: widget.addReminder,
                                  isOverButton: true,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                  labelText: '',
                                  labelTextStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Container(
                        width: 364.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      3.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Amount per dose',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 5.0, 0.0),
                                  child: Container(
                                    width: 168.0,
                                    height: 56.0,
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
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 0.0),
                                      child: TextFormField(
                                        controller:
                                            _model.singleDoseTextController ??=
                                                TextEditingController(
                                          text: widget.editMode!
                                              ? medicationFormMedicineRecord
                                                  .singleDose
                                                  .toString()
                                              : '',
                                        ),
                                        focusNode: _model.singleDoseFocusNode,
                                        autofocus: true,
                                        readOnly: widget.addReminder,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                          hintText: 'e.g; 2 at a time',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        validator: _model
                                            .singleDoseTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      3.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Total dosage',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 5.0, 0.0),
                                  child: Container(
                                    width: 168.0,
                                    height: 56.0,
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
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 0.0),
                                      child: TextFormField(
                                        controller:
                                            _model.totalDoseTextController ??=
                                                TextEditingController(
                                          text: widget.editMode!
                                              ? medicationFormMedicineRecord
                                                  .totalDose
                                                  .toString()
                                              : '',
                                        ),
                                        focusNode: _model.totalDoseFocusNode,
                                        autofocus: true,
                                        readOnly: widget.addReminder,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                          hintText: 'e.g; 24 in a pack',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        validator: _model
                                            .totalDoseTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Container(
                        width: 364.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  3.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Description',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 10.0, 5.0, 0.0),
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
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: TextFormField(
                                    controller:
                                        _model.descriptionTextTextController ??=
                                            TextEditingController(
                                      text: widget.editMode!
                                          ? medicationFormMedicineRecord
                                              .description
                                          : '',
                                    ),
                                    focusNode: _model.descriptionTextFocusNode,
                                    autofocus: true,
                                    readOnly: widget.addReminder,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'e.g; Specific Instructions',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    validator: _model
                                        .descriptionTextTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Container(
                        width: 364.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      3.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Start Date',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 10.0, 5.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          if (!widget.addReminder) {
                                            final datePicked1Date =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: getCurrentTimestamp,
                                              firstDate: getCurrentTimestamp,
                                              lastDate: DateTime(2050),
                                              builder: (context, child) {
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
                                                            fontFamily: 'Inter',
                                                            fontSize: 32.0,
                                                            letterSpacing: 0.0,
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

                                            if (datePicked1Date != null) {
                                              safeSetState(() {
                                                _model.datePicked1 = DateTime(
                                                  datePicked1Date.year,
                                                  datePicked1Date.month,
                                                  datePicked1Date.day,
                                                );
                                              });
                                            }
                                          }
                                        },
                                        text: valueOrDefault<String>(
                                          widget.editMode!
                                              ? medicationFormMedicineRecord
                                                  .startDate
                                              : (_model.datePicked1 != null
                                                  ? functions.getDate(
                                                      _model.datePicked1!)
                                                  : ''),
                                          'Choose Date',
                                        ),
                                        options: FFButtonOptions(
                                          width: 168.0,
                                          height: 56.0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      3.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Finish Date',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 5.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (!widget.addReminder) {
                                              final datePicked2Date =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    getCurrentTimestamp,
                                                firstDate: getCurrentTimestamp,
                                                lastDate: DateTime(2050),
                                                builder: (context, child) {
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

                                              if (datePicked2Date != null) {
                                                safeSetState(() {
                                                  _model.datePicked2 = DateTime(
                                                    datePicked2Date.year,
                                                    datePicked2Date.month,
                                                    datePicked2Date.day,
                                                  );
                                                });
                                              }
                                            }
                                          },
                                          text: valueOrDefault<String>(
                                            widget.editMode!
                                                ? medicationFormMedicineRecord
                                                    .endDate
                                                : (_model.datePicked2 != null
                                                    ? functions.getDate(
                                                        _model.datePicked2!)
                                                    : ''),
                                            'Choose Date',
                                          ),
                                          options: FFButtonOptions(
                                            width: 168.0,
                                            height: 56.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.editMode!
                        ? false
                        : ((_model.datePicked1 == null) ||
                            (_model.datePicked2 == null)))
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Container(
                          width: 364.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Note: Start and Finish dates for the medicine must be set to enable reminders.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 10.0),
                      child: SwitchListTile.adaptive(
                        value: _model.remindersSetValue ??= widget.editMode!
                            ? (widget.addReminder
                                ? true
                                : medicationFormMedicineRecord.setReminders)
                            : false,
                        onChanged: (widget.addReminder ||
                                (!widget.editMode! &&
                                    ((_model.datePicked1 == null) ||
                                        (_model.datePicked2 == null))))
                            ? null
                            : (newValue) async {
                                setState(
                                    () => _model.remindersSetValue = newValue);
                              },
                        title: Text(
                          'Set Reminders',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor: FlutterFlowTheme.of(context).accent1,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                    ),
                    if (_model.remindersSetValue ?? true)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0, 10.0, 15.0, 20.0),
                        child: Container(
                          width: 364.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    3.0, 0.0, 0.0, 10.0),
                                child: Text(
                                  'Reminders',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              StreamBuilder<List<RemindersRecord>>(
                                stream: queryRemindersRecord(
                                  queryBuilder: (remindersRecord) =>
                                      remindersRecord
                                          .where(
                                            'UserID',
                                            isEqualTo: FFAppState().UserID,
                                          )
                                          .where(
                                            'MedicineID',
                                            isEqualTo: widget.newMedicineID,
                                          )
                                          .orderBy('DateTimeCreated'),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<RemindersRecord>
                                      listViewRemindersRecordList =
                                      snapshot.data!;

                                  if (listViewRemindersRecordList.isEmpty) {
                                    return const Center(
                                      child: NoElementsWidget(
                                        additionalText:
                                            'Press \'Add reminder\' to set one ',
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewRemindersRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewRemindersRecord =
                                          listViewRemindersRecordList[
                                              listViewIndex];
                                      return wrapWithModel(
                                        model:
                                            _model.newReminderModels.getModel(
                                          listViewRemindersRecord.reference.id,
                                          listViewIndex,
                                        ),
                                        updateCallback: () => setState(() {}),
                                        child: NewReminderWidget(
                                          key: Key(
                                            'Keyw45_${listViewRemindersRecord.reference.id}',
                                          ),
                                          currentReminderID:
                                              listViewRemindersRecord.reference,
                                          editState: widget.editMode,
                                          index: _model.reminderIDList.length,
                                          reminderName:
                                              listViewRemindersRecord.name,
                                          deleteFromList: () async {
                                            _model.removeFromReminderIDList(
                                                listViewRemindersRecord
                                                    .reference);
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    },
                                    controller: _model.listViewController,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 10.0),
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        var remindersRecordReference =
                                            RemindersRecord.collection.doc();
                                        await remindersRecordReference
                                            .set(createRemindersRecordData(
                                          medicineID: widget.newMedicineID,
                                          userID: FFAppState().UserID,
                                          firstDate: widget.editMode!
                                              ? medicationFormMedicineRecord
                                                  .startDate
                                              : functions
                                                  .getDate(_model.datePicked1!),
                                          lastDate: widget.editMode!
                                              ? medicationFormMedicineRecord
                                                  .endDate
                                              : functions
                                                  .getDate(_model.datePicked2!),
                                          dateTimeCreated: getCurrentTimestamp,
                                          lastUpdated: widget.editMode!
                                              ? functions.stringToDate(
                                                  medicationFormMedicineRecord
                                                      .startDate)
                                              : _model.datePicked1,
                                          fIrstDateTime: widget.editMode!
                                              ? functions.stringToDate(
                                                  medicationFormMedicineRecord
                                                      .startDate)
                                              : _model.datePicked1,
                                          lastDateTime: widget.editMode!
                                              ? functions.stringToDate(
                                                  medicationFormMedicineRecord
                                                      .endDate)
                                              : _model.datePicked2,
                                        ));
                                        _model.newReminderID =
                                            RemindersRecord.getDocumentFromData(
                                                createRemindersRecordData(
                                                  medicineID:
                                                      widget.newMedicineID,
                                                  userID: FFAppState().UserID,
                                                  firstDate: widget.editMode!
                                                      ? medicationFormMedicineRecord
                                                          .startDate
                                                      : functions.getDate(
                                                          _model.datePicked1!),
                                                  lastDate: widget.editMode!
                                                      ? medicationFormMedicineRecord
                                                          .endDate
                                                      : functions.getDate(
                                                          _model.datePicked2!),
                                                  dateTimeCreated:
                                                      getCurrentTimestamp,
                                                  lastUpdated: widget.editMode!
                                                      ? functions.stringToDate(
                                                          medicationFormMedicineRecord
                                                              .startDate)
                                                      : _model.datePicked1,
                                                  fIrstDateTime: widget
                                                          .editMode!
                                                      ? functions.stringToDate(
                                                          medicationFormMedicineRecord
                                                              .startDate)
                                                      : _model.datePicked1,
                                                  lastDateTime: widget
                                                          .editMode!
                                                      ? functions.stringToDate(
                                                          medicationFormMedicineRecord
                                                              .endDate)
                                                      : _model.datePicked2,
                                                ),
                                                remindersRecordReference);
                                        _model.addToReminderIDList(
                                            _model.newReminderID!.reference);

                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add_alert,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          Text(
                                            'Add reminder',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              if (widget.addReminder) {
                                context.pushNamed('MedicationHome');
                              } else {
                                if (widget.editMode!) {
                                  _model.startDate =
                                      medicationFormMedicineRecord.startDate;
                                  _model.endDate =
                                      medicationFormMedicineRecord.endDate;
                                  setState(() {});
                                }

                                await widget.newMedicineID!
                                    .update(createMedicineRecordData(
                                  name: _model.medNameTextController.text,
                                  startDate: widget.editMode!
                                      ? _model.startDate
                                      : functions.getDate(_model.datePicked1!),
                                  endDate: widget.editMode!
                                      ? _model.endDate
                                      : functions.getDate(_model.datePicked2!),
                                  description:
                                      _model.descriptionTextTextController.text,
                                  form: _model.medTypeValue,
                                  singleDose: double.tryParse(
                                      _model.singleDoseTextController.text),
                                  totalDose: double.tryParse(
                                      _model.totalDoseTextController.text),
                                  setReminders: _model.remindersSetValue,
                                  userID: FFAppState().UserID,
                                  medId: widget.newMedicineID,
                                ));
                                context.safePop();
                              }
                            },
                            text: 'Save',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.349,
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).success,
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
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              if (widget.addReminder) {
                                context.pushNamed('MedicationHome');
                              } else {
                                await actions.deleteDocuments(
                                  _model.reminderIDList.toList(),
                                );
                                if (!widget.editMode!) {
                                  await widget.newMedicineID!.delete();
                                }
                                context.safePop();
                              }
                            },
                            text: 'Cancel',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.349,
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).error,
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
                              borderRadius: BorderRadius.circular(0.0),
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
      },
    );
  }
}
