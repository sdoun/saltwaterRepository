import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBFishingRecord extends FirestoreRecord {
  TBFishingRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "fishing_name" field.
  String? _fishingName;
  String get fishingName => _fishingName ?? '';
  bool hasFishingName() => _fishingName != null;

  // "fishing_icon" field.
  String? _fishingIcon;
  String get fishingIcon => _fishingIcon ?? '';
  bool hasFishingIcon() => _fishingIcon != null;

  // "fishing_guideContent" field.
  DocumentReference? _fishingGuideContent;
  DocumentReference? get fishingGuideContent => _fishingGuideContent;
  bool hasFishingGuideContent() => _fishingGuideContent != null;

  void _initializeFields() {
    _fishingName = snapshotData['fishing_name'] as String?;
    _fishingIcon = snapshotData['fishing_icon'] as String?;
    _fishingGuideContent =
        snapshotData['fishing_guideContent'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_fishing');

  static Stream<TBFishingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBFishingRecord.fromSnapshot(s));

  static Future<TBFishingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBFishingRecord.fromSnapshot(s));

  static TBFishingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBFishingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBFishingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBFishingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBFishingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBFishingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBFishingRecordData({
  String? fishingName,
  String? fishingIcon,
  DocumentReference? fishingGuideContent,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'fishing_name': fishingName,
      'fishing_icon': fishingIcon,
      'fishing_guideContent': fishingGuideContent,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBFishingRecordDocumentEquality implements Equality<TBFishingRecord> {
  const TBFishingRecordDocumentEquality();

  @override
  bool equals(TBFishingRecord? e1, TBFishingRecord? e2) {
    return e1?.fishingName == e2?.fishingName &&
        e1?.fishingIcon == e2?.fishingIcon &&
        e1?.fishingGuideContent == e2?.fishingGuideContent;
  }

  @override
  int hash(TBFishingRecord? e) => const ListEquality()
      .hash([e?.fishingName, e?.fishingIcon, e?.fishingGuideContent]);

  @override
  bool isValidKey(Object? o) => o is TBFishingRecord;
}
