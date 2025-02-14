import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBManagerChatRecord extends FirestoreRecord{
  TBManagerChatRecord._(super.reference, super.snapshotDatat){
    _initialLizeFields();
  }

  DocumentReference? _sendBy;
  String? _content;
  Timestamp? createdAt;

  String? get content => _content;
  DocumentReference? get sendBy => _sendBy;

  void _initialLizeFields(){
    _sendBy = snapshotData['chat_sendBy'];
    _content = snapshotData['chat_content'];
  }

  static DocumentReference createId(DocumentReference parent, String? id)
  => parent.collection('room_chatCollection').doc(id);

  static Future<void> createDoc(DocumentReference id, DocumentReference sendBy, String content) async{
    id.set(createTBManagerChatRecordData(sendBy, content, Timestamp.fromDate(DateTime.now())));
  }

  static fromSnapshot(DocumentSnapshot snapshot) => TBManagerChatRecord._(snapshot.reference, mapToFirestore(snapshot.data() as Map<String, dynamic>)) ;

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