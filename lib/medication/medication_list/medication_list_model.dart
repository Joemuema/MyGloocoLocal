import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/medication/add_refill/add_refill_widget.dart';
import '/medication/med_list_item/med_list_item_widget.dart';
import '/medication/medicine_description/medicine_description_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import 'medication_list_widget.dart' show MedicationListWidget;
import 'package:sticky_headers/sticky_headers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MedicationListModel extends FlutterFlowModel<MedicationListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Models for medListItem dynamic component.
  late FlutterFlowDynamicModels<MedListItemModel> medListItemModels1;
  // Stores action output result for [Firestore Query - Query a collection] action in medListItem widget.
  List<RemindersRecord>? pillReminderList;
  // Stores action output result for [Firestore Query - Query a collection] action in medListItem widget.
  List<RemindersRecord>? tabletReminderList;
  // Stores action output result for [Firestore Query - Query a collection] action in medListItem widget.
  List<RemindersRecord>? emulsionReminderList;
  // Stores action output result for [Firestore Query - Query a collection] action in medListItem widget.
  List<RemindersRecord>? injectionReminderList;

  @override
  void initState(BuildContext context) {
    medListItemModels1 = FlutterFlowDynamicModels(() => MedListItemModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    medListItemModels1.dispose();
  }
}
