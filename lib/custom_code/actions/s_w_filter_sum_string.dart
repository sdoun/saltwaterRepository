// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<String>?> sWFilterSumString(
  BuildContext context,
  List<String>? sW1stFilter,
  List<String>? sW2ndFilter,
  List<String>? sW3rdFilter,
  List<String>? sWfishType,
) async {
  // Add your function code here!
  try {
    final firestoreInstance = FirebaseFirestore.instance;

    // Create a reference to the collection
    final collectionReference = firestoreInstance.collection('TB_point');

    // Get all the documents in the collection
    final querySnapshot = await collectionReference.get();

    // Create an empty list to store the field values
    List<String> result = [];

    // Combine all filter conditions into one list
    List<String> wCondition = (sW1stFilter ?? []) +
        (sW2ndFilter ?? []) +
        (sW3rdFilter ?? []) +
        (sWfishType ?? []);

    // Loop through all the documents
    for (final documentSnapshot in querySnapshot.docs) {
      // Get the 'point_tags' field value and convert to a List<String>
      final tags = List<String>.from(
          documentSnapshot.get('point_tags') as List<dynamic>);

      // Add true items from 'point_tags_boolen' to tagsFromBoolenStruct

      // Check if all items in 'wCondition' are in 'tagsFromBoolenStruct'
      if (wCondition.every((element) => tags.contains(element))) {
        final nameValue = documentSnapshot.get('point_name') as String;
        result.add(nameValue);
      }
    }

    return result;
  } catch (e) {
    print('error detected $e');
    return null;
  }
}
