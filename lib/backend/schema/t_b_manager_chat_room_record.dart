import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBManagerChatRoomRecord extends FirestoreRecord{
  TBManagerChatRoomRecord._(
      super.reference,
      super.snapshotData
      ){
      _initialLizeFields();
  }


  DocumentReference? _chatUser;
  DocumentReference? get chatUser => _chatUser;

  void _initialLizeFields(){
    _chatUser = snapshotData['room_chatUser'] as DocumentReference;
  }

  static fromSnapshot(DocumentSnapshot snapshot) => TBManagerChatRoomRecord._(snapshot.reference, snapshot.data() as Map<String, dynamic>);
}