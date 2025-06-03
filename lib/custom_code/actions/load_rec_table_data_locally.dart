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

Future<List<DietRecsRecord>> loadRecTableDataLocally(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList(key);

  if (jsonList == null) return [];

  return jsonList.map((jsonStr) {
    final map = jsonDecode(jsonStr) as Map<String, dynamic>;

    final ref = FirebaseFirestore.instance.doc(map['refPath']);

    return DietRecsRecord.getDocumentFromData(map, ref);
  }).toList();
}
