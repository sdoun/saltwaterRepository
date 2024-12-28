// Automatic FlutterFlow imports
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<String>?> deletePointLikes(
    BuildContext context,
    DocumentReference? user
    ) async {
  // Add your function code here!
  try {
    final firestoreInstance = FirebaseFirestore.instance;

    // Create a reference to the collection
    final collectionReference = firestoreInstance.collection('TB_point').where('point_liked_by', arrayContains: currentUserReference);

    // Get all the documents in the collection
    final querySnapshot = await collectionReference.get();

    // Create an empty list to store the field values
    List<String> tags = [];
    // Combine all filter conditions into one list

    // Loop through all the documents
    for (final documentSnapshot in querySnapshot.docs) {
     print(documentSnapshot.data());
     final record = TBPointRecord.fromSnapshot(documentSnapshot);
     final likedBy = record.pointLikedBy;
     print('likedBy is $likedBy');
     likedBy.remove(currentUserReference);
     print('likedBy is $likedBy');
     record.reference.update({
       'point_liked_by' : likedBy
     });
     print(record.pointLikedBy);

    }
    tags = [];
    return null;
  } catch (e) {
    print('error detected $e');
    return null;
  }
}
