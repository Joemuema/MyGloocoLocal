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

Future storeRecipeDataLocally(
  List<RecipesRecord> data,
  String key,
) async {
  final prefs = await SharedPreferences.getInstance();

  final jsonList = data.map((record) {
    final recordMap = {
      'title': record.title,
      'prepTime': record.prepTime,
      'cookingTime': record.cookingTime,
      'servings': record.servings,
      'protein': record.protein,
      'carbohydrate': record.carbohydrate,
      'fibre': record.fibre,
      'ingredients': record.ingredients,
      'instructions': record.instructions,
      'picture': record.picture,
      'fat': record.fat,
      'code': record.code,
      'refPath': record.reference.path,
    };
    return jsonEncode(recordMap);
  }).toList();

  await prefs.setStringList(key, jsonList);
}
