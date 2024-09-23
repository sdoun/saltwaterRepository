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

Future<List<String>?> seawallAmenListString(
  bool isBed,
  bool isRestaurant,
  bool isShop,
  bool isToilet,
) async {
  // Add your function code here!
  List<String> resultString = [];
  if (isBed) {
    resultString.add('숙소');
  }
  if (isRestaurant) {
    resultString.add('식당');
  }
  if (isShop) {
    resultString.add('매점');
  }
  if (isToilet) {
    resultString.add('화장실');
  }
  return resultString;
}
