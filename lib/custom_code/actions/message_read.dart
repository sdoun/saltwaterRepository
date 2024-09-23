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

Future messageRead(
  DocumentReference currentUser,
  DocumentReference chatRoomRef,
) async {
  // Add your function code here!
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    // TB_ChatRoom의 서브컬렉션 TB_chat 참조
    final chatCollectionRef = chatRoomRef.collection('TB_chat');

    // createdBy가 currentUser가 아니고 chat_isRead가 false인 문서 쿼리
    final querySnapshot = await chatCollectionRef
        .where('createdBy', isNotEqualTo: currentUser)
        .where('chat_isRead', isEqualTo: false)
        .get();

    // 일괄 업데이트를 위한 WriteBatch 생성
    final batch = _firestore.batch();

    // 쿼리 결과의 각 문서에 대해 chat_isRead를 true로 설정
    for (final doc in querySnapshot.docs) {
      batch.update(doc.reference, {'chat_isRead': true});
      print('$doc');
    }

    // 일괄 업데이트 실행
    await batch.commit();

    print('${querySnapshot.docs.length}개의 메시지가 읽음 처리되었습니다.');
  } catch (e) {
    print('오류 발생: $e');
  }
}
