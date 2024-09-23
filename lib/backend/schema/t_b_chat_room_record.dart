import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBChatRoomRecord extends FirestoreRecord {
  TBChatRoomRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "room_id" field.
  String? _roomId;
  String get roomId => _roomId ?? '';
  bool hasRoomId() => _roomId != null;

  // "room_createdAt" field.
  DateTime? _roomCreatedAt;
  DateTime? get roomCreatedAt => _roomCreatedAt;
  bool hasRoomCreatedAt() => _roomCreatedAt != null;

  // "room_participant" field.
  List<String>? _roomParticipant;
  List<String> get roomParticipant => _roomParticipant ?? const [];
  bool hasRoomParticipant() => _roomParticipant != null;

  // "room_buyer" field.
  String? _roomBuyer;
  String get roomBuyer => _roomBuyer ?? '';
  bool hasRoomBuyer() => _roomBuyer != null;

  // "room_postDocID" field.
  String? _roomPostDocID;
  String get roomPostDocID => _roomPostDocID ?? '';
  bool hasRoomPostDocID() => _roomPostDocID != null;

  // "room_postID" field.
  DocumentReference? _roomPostID;
  DocumentReference? get roomPostID => _roomPostID;
  bool hasRoomPostID() => _roomPostID != null;

  // "room_used" field.
  bool? _roomUsed;
  bool get roomUsed => _roomUsed ?? false;
  bool hasRoomUsed() => _roomUsed != null;

  // "room_participants" field.
  List<DocumentReference>? _roomParticipants;
  List<DocumentReference> get roomParticipants => _roomParticipants ?? const [];
  bool hasRoomParticipants() => _roomParticipants != null;

  void _initializeFields() {
    _roomId = snapshotData['room_id'] as String?;
    _roomCreatedAt = snapshotData['room_createdAt'] as DateTime?;
    _roomParticipant = getDataList(snapshotData['room_participant']);
    _roomBuyer = snapshotData['room_buyer'] as String?;
    _roomPostDocID = snapshotData['room_postDocID'] as String?;
    _roomPostID = snapshotData['room_postID'] as DocumentReference?;
    _roomUsed = snapshotData['room_used'] as bool?;
    _roomParticipants = getDataList(snapshotData['room_participants']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_chatRoom');

  static Stream<TBChatRoomRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBChatRoomRecord.fromSnapshot(s));

  static Future<TBChatRoomRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBChatRoomRecord.fromSnapshot(s));

  static TBChatRoomRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBChatRoomRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBChatRoomRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBChatRoomRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBChatRoomRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBChatRoomRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBChatRoomRecordData({
  String? roomId,
  DateTime? roomCreatedAt,
  String? roomBuyer,
  String? roomPostDocID,
  DocumentReference? roomPostID,
  bool? roomUsed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'room_id': roomId,
      'room_createdAt': roomCreatedAt,
      'room_buyer': roomBuyer,
      'room_postDocID': roomPostDocID,
      'room_postID': roomPostID,
      'room_used': roomUsed,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBChatRoomRecordDocumentEquality implements Equality<TBChatRoomRecord> {
  const TBChatRoomRecordDocumentEquality();

  @override
  bool equals(TBChatRoomRecord? e1, TBChatRoomRecord? e2) {
    const listEquality = ListEquality();
    return e1?.roomId == e2?.roomId &&
        e1?.roomCreatedAt == e2?.roomCreatedAt &&
        listEquality.equals(e1?.roomParticipant, e2?.roomParticipant) &&
        e1?.roomBuyer == e2?.roomBuyer &&
        e1?.roomPostDocID == e2?.roomPostDocID &&
        e1?.roomPostID == e2?.roomPostID &&
        e1?.roomUsed == e2?.roomUsed &&
        listEquality.equals(e1?.roomParticipants, e2?.roomParticipants);
  }

  @override
  int hash(TBChatRoomRecord? e) => const ListEquality().hash([
        e?.roomId,
        e?.roomCreatedAt,
        e?.roomParticipant,
        e?.roomBuyer,
        e?.roomPostDocID,
        e?.roomPostID,
        e?.roomUsed,
        e?.roomParticipants
      ]);

  @override
  bool isValidKey(Object? o) => o is TBChatRoomRecord;
}
