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

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

Future inintKakao() async {
  // Add your function code here!
  kakao.KakaoSdk.init(
    nativeAppKey: '8791b3ab8310a250f675a858e5f9ec45',
    javaScriptAppKey: '945dafc9a4ec59531a381f01ea0b9081',
  );
}
