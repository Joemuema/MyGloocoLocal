// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future convertAndStoreTimeField() async {
  // Get the collection reference
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('BGreadings');

  // Get all documents in the collection
  QuerySnapshot querySnapshot = await collectionRef.get();

  // Loop through each document
  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    // Get hour, minute, and date fields from the document
    int hour = doc['Hour'];
    int minute = doc['Minute'];
    String dateString = doc[
        'Date']; // Assuming the date is stored in a field named 'date' in format 'dd/MM/yyyy'

    // Parse the date string to a DateTime object
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime parsedDate = dateFormat.parse(dateString);

    // Create a DateTime object with the parsed date and the given hour and minute
    DateTime dateTime = DateTime(
        parsedDate.year, parsedDate.month, parsedDate.day, hour, minute);

    // Update the document with the new time field
    await doc.reference.update({'Time': dateTime});
  }
}
