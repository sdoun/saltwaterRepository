import 'dart:async';

import 'package:collection/collection.dart';
import 'package:google_maps/google_maps.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBManagerChatRecord extends FirestoreRecord{
  TBManagerChatRecord._(super.reference, super.snapshotDatat){
    _initialLizeFields();
  }

  DocumentReference? sendBy;
  String? content;
  Timestamp? createdAt;

  void _initialLizeFields(){
    sendBy = snapshotData['chat_sendBy'];
  }

  static DocumentReference createId(DocumentReference parent, String? id)
  => parent.collection('room_chatCollection').doc(id);

  static Future<void> createDoc(DocumentReference parentId, DocumentReference sendBy, String content) async{
    parentId.set(createTBManagerChatRecordData(sendBy, content, Timestamp.fromDate(DateTime.now())));
  }

  static Map<String, dynamic> createTBManagerChatRecordData(
      DocumentReference sendBy,
      String content,
      Timestamp createdAt
      ){
    final firestoreData = mapToFirestore({
      'chat_sendBy' : sendBy,
      'chat_content' : content,
      'chat_createdAt' : createdAt
    }.withoutNulls);
    return firestoreData;
  }
}