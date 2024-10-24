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

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import '/auth/firebase_auth/auth_util.dart';
import '../../auth/auth_manager.dart';

Future loginKakao() async {
  // Add your function code here!
  // 1. 카카오톡 사용 혹은 계정을 이용하여 카카오 로그인
  final HttpsCallable sdkCheckCallable =
      FirebaseFunctions.instance.httpsCallable('redirectionCloudLog');
  try {
    if (await kakao.isKakaoTalkInstalled()) {
      await kakao.UserApi.instance.loginWithKakaoTalk();
    } else {
      await kakao.UserApi.instance.loginWithKakaoAccount();
    }

    sdkCheckCallable.call(<String, dynamic>{'logParam': 'sdk call success!'});
  } catch (e) {
    print(e);
    sdkCheckCallable.call(<String, dynamic>{'sdk call error log': e});
  }

  // 2. 카카오 유저 정보로부터 앱에서 사용할 유저 데이터 가공
  final kakaoUser = await kakao.UserApi.instance.me();
  print('### kakaoUser: $kakaoUser');
  final user = {
    'email': kakaoUser.kakaoAccount?.email,
    'displayName': kakaoUser.properties?['nickname'],
    'photoURL': kakaoUser.kakaoAccount?.profile?.profileImageUrl ??
        'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EC%95%B1%EC%95%84%EC%9D%B4%EC%BD%98%2F%EC%A7%A0%EB%82%B4%ED%88%AC%EC%96%B4%2B%EC%96%B4%ED%94%8C%EB%B2%84%EC%A0%84%2B%EC%9B%90%EB%B3%B8_%EB%8F%84%EC%98%81%EC%88%98%EC%A0%95.jpg?alt=media&token=11a95a9b-1721-461b-b8e8-3d04fcaef2d2',
    'uid': 'kakao_${kakaoUser.id}',
    'phoneNumber': kakaoUser.kakaoAccount?.phoneNumber,
  };
  print('### user before remove null: $user');
  sdkCheckCallable.call(<String, dynamic>{'user data': user});
  // null 데이터 제거
  user.removeWhere((key, value) => value == null);
  print('### user: $user');

  // 3. cloud functions 를 이용하여 커스텀 토큰 생성
  HttpsCallable tokenCallable =
      FirebaseFunctions.instanceFor(region: 'asia-northeast3')
          .httpsCallable('createCustomToken');
  final response = await tokenCallable.call({'user': user});
  print('Custom token: ${response.data['token']}');

  final token = response.data['token'];
  print('### token: $token');
  sdkCheckCallable.call(<String, dynamic>{'token data': token});

  // 4. 커스텀 토큰으로 로그인 진행
  try {
    final credential = await FirebaseAuth.instance.signInWithCustomToken(token);
    print('### userCredential: $credential');

    // 5. DB 에 유저 데이터 동록
    await maybeCreateUser(credential.user!);
  } catch (e) {
    print(e);
    sdkCheckCallable.call(<String, dynamic>{'logParam': e});
  }
  // FlutterFlow의 AuthState 업데이
}
