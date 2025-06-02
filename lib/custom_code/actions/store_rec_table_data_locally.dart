// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Future storeRecTableDataLocally(
  List<DietRecsRecord> data,
  String key,
) async {
  final prefs = await SharedPreferences.getInstance();

  final jsonList = data.map((record) {
    final recordMap = {
      'group': record.group,
      'approxCals': record.approxCals,
      'gramsAvg': record.gramsAvg,
      'recs': record.recs,
      'refPath': record.reference.path,
    };
    return jsonEncode(recordMap);
  }).toList();

  await prefs.setStringList(key, jsonList);
}
