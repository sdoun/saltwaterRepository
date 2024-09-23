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

Future deleteUnusedChatRoom() async {
  // Add your function code here!
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    // 4. TB_chatRoom 컬렉션 참조 가져오기
    final chatRoomsRef = _firestore.collection('TB_chatRoom');

    // 5. isused가 false인 문서 쿼리
    final querySnapshot =
        await chatRoomsRef.where('room_used', isEqualTo: false).get();

    // 6. 쿼리 결과에서 문서 ID 추출
    final docIds = querySnapshot.docs.map((doc) => doc.id).toList();

    // 7. 문서 ID 별로 삭제 작업 수행
    for (final docId in docIds) {
      await chatRoomsRef.doc(docId).delete();
    }
  } catch (e) {
    print('unexpected Exception');
  }
}
