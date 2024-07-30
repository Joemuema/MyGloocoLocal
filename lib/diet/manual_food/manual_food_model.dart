import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'manual_food_widget.dart' show ManualFoodWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ManualFoodModel extends FlutterFlowModel<ManualFoodWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Manualfood widget.
  FocusNode? manualfoodFocusNode;
  TextEditingController? manualfoodTextController;
  String? Function(BuildContext, String?)? manualfoodTextControllerValidator;
  String? _manualfoodTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Food entry is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    manualfoodTextControllerValidator = _manualfoodTextControllerValidator;
  }

  @override
  void dispose() {
    manualfoodFocusNode?.dispose();
    manualfoodTextController?.dispose();
  }
}
