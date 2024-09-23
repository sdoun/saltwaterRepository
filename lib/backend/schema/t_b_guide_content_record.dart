import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBGuideContentRecord extends FirestoreRecord {
  TBGuideContentRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "content_title" field.
  String? _contentTitle;
  String get contentTitle => _contentTitle ?? '';
  bool hasContentTitle() => _contentTitle != null;

  // "content_content" field.
  String? _contentContent;
  String get contentContent => _contentContent ?? '';
  bool hasContentContent() => _contentContent != null;

  // "content_image" field.
  String? _contentImage;
  String get contentImage => _contentImage ?? '';
  bool hasContentImage() => _contentImage != null;

  // "content_createdAt" field.
  DateTime? _contentCreatedAt;
  DateTime? get contentCreatedAt => _contentCreatedAt;
  bool hasContentCreatedAt() => _contentCreatedAt != null;

  // "content_topic" field.
  String? _contentTopic;
  String get contentTopic => _contentTopic ?? '';
  bool hasContentTopic() => _contentTopic != null;

  void _initializeFields() {
    _contentTitle = snapshotData['content_title'] as String?;
    _contentContent = snapshotData['content_content'] as String?;
    _contentImage = snapshotData['content_image'] as String?;
    _contentCreatedAt = snapshotData['content_createdAt'] as DateTime?;
    _contentTopic = snapshotData['content_topic'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_guideContent');

  static Stream<TBGuideContentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBGuideContentRecord.fromSnapshot(s));

  static Future<TBGuideContentRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBGuideContentRecord.fromSnapshot(s));

  static TBGuideContentRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBGuideContentRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBGuideContentRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBGuideContentRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBGuideContentRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBGuideContentRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBGuideContentRecordData({
  String? contentTitle,
  String? contentContent,
  String? contentImage,
  DateTime? contentCreatedAt,
  String? contentTopic,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'content_title': contentTitle,
      'content_content': contentContent,
      'content_image': contentImage,
      'content_createdAt': contentCreatedAt,
      'content_topic': contentTopic,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBGuideContentRecordDocumentEquality
    implements Equality<TBGuideContentRecord> {
  const TBGuideContentRecordDocumentEquality();

  @override
  bool equals(TBGuideContentRecord? e1, TBGuideContentRecord? e2) {
    return e1?.contentTitle == e2?.contentTitle &&
        e1?.contentContent == e2?.contentContent &&
        e1?.contentImage == e2?.contentImage &&
        e1?.contentCreatedAt == e2?.contentCreatedAt &&
        e1?.contentTopic == e2?.contentTopic;
  }

  @override
  int hash(TBGuideContentRecord? e) => const ListEquality().hash([
        e?.contentTitle,
        e?.contentContent,
        e?.contentImage,
        e?.contentCreatedAt,
        e?.contentTopic
      ]);

  @override
  bool isValidKey(Object? o) => o is TBGuideContentRecord;
}
