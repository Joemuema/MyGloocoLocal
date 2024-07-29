import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/medication/med_list_item/med_list_item_widget.dart';
import 'medication_list_widget.dart' show MedicationListWidget;
import 'package:flutter/material.dart';

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
