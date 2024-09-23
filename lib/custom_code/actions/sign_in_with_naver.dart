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

import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future signInWithNaver() async {
  // Add your function code here!
  final String clientId = '1ctb9frHDUaeRczLmGqT';
  final String redirectUri =
      'https://us-central1-salt-water-beta-ver1-4dujup.cloudfunctions.net/naverLoginCallback'; // We will create this on Google Cloud
  final String state = base64Url.encode(List<int>.generate(
      16, (_) => Random().nextInt(255))); // Random nonce used for security
  final Uri url = Uri.parse(
      'https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&state=$state');
  print(
      "Opening Naver SSO (Naver will call our Cloud Function which will use Callback Scheme to re-enter app..");
  await launchUrl(url); // flutter pub get url_launcher
}
