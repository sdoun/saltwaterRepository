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

import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>?> packageTitleSearch(
  List<String>? area,
  List<String>? type,
  List<String>? typedetailed,
) async {
  // Add your function code here!

  final firestoreInstance = FirebaseFirestore.instance;
  final packageReference = firestoreInstance.collection('TB_travelPackage');
  final querySnapshot = await packageReference.get();

  List<DocumentSnapshot> result = [];
  List<String> titleList = [];

  for (var package in querySnapshot.docs) {
    final packageArea = package.get('package_area') as String;
    final packageType = package.get('package_type') as String;
    final packageDetailed = package.get('package_typeDetailed') as String;

    bool areaMatch = area == null || area.contains(packageArea);
    bool typeMatch = type == null || type.contains(packageType);
    bool detailedMatch =
        typedetailed == null || typedetailed.contains(packageDetailed);

    if (areaMatch && typeMatch && detailedMatch) {
      final packageName = package.get('package_name') as String;
      titleList.add(packageName!);
    }
  }

  return titleList;
}
