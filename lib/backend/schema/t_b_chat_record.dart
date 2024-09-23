import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBChatRecord extends FirestoreRecord {
  TBChatRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "chat_sendBy" field.
  String? _chatSendBy;
  String get chatSendBy => _chatSendBy ?? '';
  bool hasChatSendBy() => _chatSendBy != null;

  // "chat_content" field.
  String? _chatContent;
  String get chatContent => _chatContent ?? '';
  bool hasChatContent() => _chatContent != null;

  // "chat_createdAt" field.
  DateTime? _chatCreatedAt;
  DateTime? get chatCreatedAt => _chatCreatedAt;
  bool hasChatCreatedAt() => _chatCreatedAt != null;

  // "chat_chatRoom" field.
  DocumentReference? _chatChatRoom;
  DocumentReference? get chatChatRoom => _chatChatRoom;
  bool hasChatChatRoom() => _chatChatRoom != null;

  // "chat_createdBy" field.
  DocumentReference? _chatCreatedBy;
  DocumentReference? get chatCreatedBy => _chatCreatedBy;
  bool hasChatCreatedBy() => _chatCreatedBy != null;

  // "chat_isRead" field.
  bool? _chatIsRead;
  bool get chatIsRead => _chatIsRead ?? false;
  bool hasChatIsRead() => _chatIsRead != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _chatSendBy = snapshotData['chat_sendBy'] as String?;
    _chatContent = snapshotData['chat_content'] as String?;
    _chatCreatedAt = snapshotData['chat_createdAt'] as DateTime?;
    _chatChatRoom = snapshotData['chat_chatRoom'] as DocumentReference?;
    _chatCreatedBy = snapshotData['chat_createdBy'] as DocumentReference?;
    _chatIsRead = snapshotData['chat_isRead'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('TB_chat')
          : FirebaseFirestore.instance.collectionGroup('TB_chat');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('TB_chat').doc(id);

  static Stream<TBChatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBChatRecord.fromSnapshot(s));

  static Future<TBChatRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBChatRecord.fromSnapshot(s));

  static TBChatRecord fromSnapshot(DocumentSnapshot snapshot) => TBChatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBChatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBChatRecordData({
  String? chatSendBy,
  String? chatContent,
  DateTime? chatCreatedAt,
  DocumentReference? chatChatRoom,
  DocumentReference? chatCreatedBy,
  bool? chatIsRead,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chat_sendBy': chatSendBy,
      'chat_content': chatContent,
      'chat_createdAt': chatCreatedAt,
      'chat_chatRoom': chatChatRoom,
      'chat_createdBy': chatCreatedBy,
      'chat_isRead': chatIsRead,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBChatRecordDocumentEquality implements Equality<TBChatRecord> {
  const TBChatRecordDocumentEquality();

  @override
  bool equals(TBChatRecord? e1, TBChatRecord? e2) {
    return e1?.chatSendBy == e2?.chatSendBy &&
        e1?.chatContent == e2?.chatContent &&
        e1?.chatCreatedAt == e2?.chatCreatedAt &&
        e1?.chatChatRoom == e2?.chatChatRoom &&
        e1?.chatCreatedBy == e2?.chatCreatedBy &&
        e1?.chatIsRead == e2?.chatIsRead;
  }

  @override
  int hash(TBChatRecord? e) => const ListEquality().hash([
        e?.chatSendBy,
        e?.chatContent,
        e?.chatCreatedAt,
        e?.chatChatRoom,
        e?.chatCreatedBy,
        e?.chatIsRead
      ]);

  @override
  bool isValidKey(Object? o) => o is TBChatRecord;
}
