import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBFishRecord extends FirestoreRecord {
  TBFishRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "fish_name" field.
  String? _fishName;
  String get fishName => _fishName ?? '';
  bool hasFishName() => _fishName != null;

  // "fish_icon" field.
  String? _fishIcon;
  String get fishIcon => _fishIcon ?? '';
  bool hasFishIcon() => _fishIcon != null;

  // "fish_type" field.
  String? _fishType;
  String get fishType => _fishType ?? '';
  bool hasFishType() => _fishType != null;

  void _initializeFields() {
    _fishName = snapshotData['fish_name'] as String?;
    _fishIcon = snapshotData['fish_icon'] as String?;
    _fishType = snapshotData['fish_type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_fish');

  static Stream<TBFishRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBFishRecord.fromSnapshot(s));

  static Future<TBFishRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBFishRecord.fromSnapshot(s));

  static TBFishRecord fromSnapshot(DocumentSnapshot snapshot) => TBFishRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBFishRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBFishRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBFishRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBFishRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBFishRecordData({
  String? fishName,
  String? fishIcon,
  String? fishType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'fish_name': fishName,
      'fish_icon': fishIcon,
      'fish_type': fishType,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBFishRecordDocumentEquality implements Equality<TBFishRecord> {
  const TBFishRecordDocumentEquality();

  @override
  bool equals(TBFishRecord? e1, TBFishRecord? e2) {
    return e1?.fishName == e2?.fishName &&
        e1?.fishIcon == e2?.fishIcon &&
        e1?.fishType == e2?.fishType;
  }

  @override
  int hash(TBFishRecord? e) =>
      const ListEquality().hash([e?.fishName, e?.fishIcon, e?.fishType]);

  @override
  bool isValidKey(Object? o) => o is TBFishRecord;
}
