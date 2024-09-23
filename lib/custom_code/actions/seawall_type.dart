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

Future<List<String>?> seawallType(
  bool isTetra,
  bool isShift,
) async {
  // Add your function code here!
  List<String> resultString = [];
  if (isTetra) {
    resultString.add('외향테트라');
  }
  if (isShift) {
    resultString.add('외향시프트');
  }
  return resultString;
}
