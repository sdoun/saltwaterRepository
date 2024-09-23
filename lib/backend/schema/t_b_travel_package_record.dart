import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBTravelPackageRecord extends FirestoreRecord {
  TBTravelPackageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "package_name" field.
  String? _packageName;
  String get packageName => _packageName ?? '';
  bool hasPackageName() => _packageName != null;

  // "package_area" field.
  String? _packageArea;
  String get packageArea => _packageArea ?? '';
  bool hasPackageArea() => _packageArea != null;

  // "package_type" field.
  String? _packageType;
  String get packageType => _packageType ?? '';
  bool hasPackageType() => _packageType != null;

  // "package_typeDetailed" field.
  String? _packageTypeDetailed;
  String get packageTypeDetailed => _packageTypeDetailed ?? '';
  bool hasPackageTypeDetailed() => _packageTypeDetailed != null;

  void _initializeFields() {
    _packageName = snapshotData['package_name'] as String?;
    _packageArea = snapshotData['package_area'] as String?;
    _packageType = snapshotData['package_type'] as String?;
    _packageTypeDetailed = snapshotData['package_typeDetailed'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_travelPackage');

  static Stream<TBTravelPackageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBTravelPackageRecord.fromSnapshot(s));

  static Future<TBTravelPackageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBTravelPackageRecord.fromSnapshot(s));

  static TBTravelPackageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBTravelPackageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBTravelPackageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBTravelPackageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBTravelPackageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBTravelPackageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBTravelPackageRecordData({
  String? packageName,
  String? packageArea,
  String? packageType,
  String? packageTypeDetailed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'package_name': packageName,
      'package_area': packageArea,
      'package_type': packageType,
      'package_typeDetailed': packageTypeDetailed,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBTravelPackageRecordDocumentEquality
    implements Equality<TBTravelPackageRecord> {
  const TBTravelPackageRecordDocumentEquality();

  @override
  bool equals(TBTravelPackageRecord? e1, TBTravelPackageRecord? e2) {
    return e1?.packageName == e2?.packageName &&
        e1?.packageArea == e2?.packageArea &&
        e1?.packageType == e2?.packageType &&
        e1?.packageTypeDetailed == e2?.packageTypeDetailed;
  }

  @override
  int hash(TBTravelPackageRecord? e) => const ListEquality().hash(
      [e?.packageName, e?.packageArea, e?.packageType, e?.packageTypeDetailed]);

  @override
  bool isValidKey(Object? o) => o is TBTravelPackageRecord;
}
