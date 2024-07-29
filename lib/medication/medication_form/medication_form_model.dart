import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/medication/new_reminder/new_reminder_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'medication_form_widget.dart' show MedicationFormWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MedicationFormModel extends FlutterFlowModel<MedicationFormWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> reminderIDList = [];
  void addToReminderIDList(DocumentReference item) => reminderIDList.add(item);
  void removeFromReminderIDList(DocumentReference item) =>
      reminderIDList.remove(item);
  void removeAtIndexFromReminderIDList(int index) =>
      reminderIDList.removeAt(index);
  void insertAtIndexInReminderIDList(int index, DocumentReference item) =>
      reminderIDList.insert(index, item);
  void updateReminderIDListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      reminderIDList[index] = updateFn(reminderIDList[index]);

  String startDate = '2000-01-01';

  String endDate = '2100-01-01';

  bool reminderSetState = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for mainColumn widget.
  ScrollController? mainColumn;
  // State field(s) for MedName widget.
  FocusNode? medNameFocusNode;
  TextEditingController? medNameTextController;
  String? Function(BuildContext, String?)? medNameTextControllerValidator;
  // State field(s) for MedType widget.
  String? medTypeValue;
  FormFieldController<String>? medTypeValueController;
  // State field(s) for SingleDose widget.
  FocusNode? singleDoseFocusNode;
  TextEditingController? singleDoseTextController;
  String? Function(BuildContext, String?)? singleDoseTextControllerValidator;
  // State field(s) for TotalDose widget.
  FocusNode? totalDoseFocusNode;
  TextEditingController? totalDoseTextController;
  String? Function(BuildContext, String?)? totalDoseTextControllerValidator;
  // State field(s) for DescriptionText widget.
  FocusNode? descriptionTextFocusNode;
  TextEditingController? descriptionTextTextController;
  String? Function(BuildContext, String?)?
      descriptionTextTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for RemindersSet widget.
  bool? remindersSetValue;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // Models for newReminder dynamic component.
  late FlutterFlowDynamicModels<NewReminderModel> newReminderModels;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  RemindersRecord? newReminderID;

  @override
  void initState(BuildContext context) {
    mainColumn = ScrollController();
    listViewController = ScrollController();
    newReminderModels = FlutterFlowDynamicModels(() => NewReminderModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    mainColumn?.dispose();
    medNameFocusNode?.dispose();
    medNameTextController?.dispose();

    singleDoseFocusNode?.dispose();
    singleDoseTextController?.dispose();

    totalDoseFocusNode?.dispose();
    totalDoseTextController?.dispose();

    descriptionTextFocusNode?.dispose();
    descriptionTextTextController?.dispose();

    listViewController?.dispose();
    newReminderModels.dispose();
  }
}
