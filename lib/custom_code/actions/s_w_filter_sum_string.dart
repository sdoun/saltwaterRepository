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
    print('1필터 길이: ${sW1stFilter?.length}');
    print('2필터 길이: ${sW2ndFilter?.length}');
    print('3필터 길이: ${sW3rdFilter?.length}');

    // Get all the documents in the collection
    final querySnapshot = await collectionReference.get();

    // Create an empty list to store the field values
    List<String> result = [];
    List<String> tags = [];
    // Combine all filter conditions into one list
    List<String> wCondition = (sW1stFilter ?? []) +
        (sW2ndFilter ?? []) +
        (sW3rdFilter ?? []) +
        (sWfishType ?? []);

    print('전체필터길이${wCondition.length}');

    // Loop through all the documents
    for (final documentSnapshot in querySnapshot.docs) {
      // Get the 'point_tags' field value and convert to a List<String>
      tags = [];
      if (documentSnapshot.data().containsKey('point_tags')) {
        tags.addAll(List<String>.from(documentSnapshot.get('point_tags') as List<dynamic>));
      }

      // Safely get point_fishes
      if (documentSnapshot.data().containsKey('point_fishes')) {
        tags.addAll(List<String>.from(documentSnapshot.get('point_fishes') as List<dynamic>));
      }
      print('태그길이: ${tags.length}');

      if (wCondition.isNotEmpty) {
        if (wCondition.every((element) => tags.contains(element))) {
          final nameValue = documentSnapshot.get('point_name') as String;
          result.add(nameValue);
          print('필터 작동');
        }
      } else {
        // If wCondition is empty, add all documents
        final nameValue = documentSnapshot.get('point_name') as String;
        print('필터값 비어있음');
        result.add(nameValue);
      }
    }
    print('검색결과 길이${result.length}');
    tags = [];
    return result;
  } catch (e) {
    print('error detected $e');
    return null;
  }
}
