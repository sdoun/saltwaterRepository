import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBPointTagsRecord extends FirestoreRecord {
  TBPointTagsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "tag_name" field.
  String? _tagName;
  String get tagName => _tagName ?? '';
  bool hasTagName() => _tagName != null;

  // "tag_icon" field.
  String? _tagIcon;
  String get tagIcon => _tagIcon ?? '';
  bool hasTagIcon() => _tagIcon != null;

  void _initializeFields() {
    _tagName = snapshotData['tag_name'] as String?;
    _tagIcon = snapshotData['tag_icon'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_point_tags');

  static Stream<TBPointTagsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBPointTagsRecord.fromSnapshot(s));

  static Future<TBPointTagsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBPointTagsRecord.fromSnapshot(s));

  static TBPointTagsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBPointTagsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBPointTagsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBPointTagsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBPointTagsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBPointTagsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBPointTagsRecordData({
  String? tagName,
  String? tagIcon,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'tag_name': tagName,
      'tag_icon': tagIcon,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBPointTagsRecordDocumentEquality implements Equality<TBPointTagsRecord> {
  const TBPointTagsRecordDocumentEquality();

  @override
  bool equals(TBPointTagsRecord? e1, TBPointTagsRecord? e2) {
    return e1?.tagName == e2?.tagName && e1?.tagIcon == e2?.tagIcon;
  }

  @override
  int hash(TBPointTagsRecord? e) =>
      const ListEquality().hash([e?.tagName, e?.tagIcon]);

  @override
  bool isValidKey(Object? o) => o is TBPointTagsRecord;
}
