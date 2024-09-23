import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBNotificationRecord extends FirestoreRecord {
  TBNotificationRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "notificatin_title" field.
  String? _notificatinTitle;
  String get notificatinTitle => _notificatinTitle ?? '';
  bool hasNotificatinTitle() => _notificatinTitle != null;

  // "notification_content" field.
  String? _notificationContent;
  String get notificationContent => _notificationContent ?? '';
  bool hasNotificationContent() => _notificationContent != null;

  void _initializeFields() {
    _notificatinTitle = snapshotData['notificatin_title'] as String?;
    _notificationContent = snapshotData['notification_content'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_notification');

  static Stream<TBNotificationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBNotificationRecord.fromSnapshot(s));

  static Future<TBNotificationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBNotificationRecord.fromSnapshot(s));

  static TBNotificationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBNotificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBNotificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBNotificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBNotificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBNotificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBNotificationRecordData({
  String? notificatinTitle,
  String? notificationContent,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'notificatin_title': notificatinTitle,
      'notification_content': notificationContent,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBNotificationRecordDocumentEquality
    implements Equality<TBNotificationRecord> {
  const TBNotificationRecordDocumentEquality();

  @override
  bool equals(TBNotificationRecord? e1, TBNotificationRecord? e2) {
    return e1?.notificatinTitle == e2?.notificatinTitle &&
        e1?.notificationContent == e2?.notificationContent;
  }

  @override
  int hash(TBNotificationRecord? e) =>
      const ListEquality().hash([e?.notificatinTitle, e?.notificationContent]);

  @override
  bool isValidKey(Object? o) => o is TBNotificationRecord;
}
