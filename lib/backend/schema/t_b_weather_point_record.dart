import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBWeatherPointRecord extends FirestoreRecord {
  TBWeatherPointRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "area" field.
  String? _area;
  String get area => _area ?? '';
  bool hasArea() => _area != null;

  // "sta_cde" field.
  String? _staCde;
  String get staCde => _staCde ?? '';
  bool hasStaCde() => _staCde != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  bool hasStatus() => _status != null;

  // "latlng" field.
  LatLng? _latlng;
  LatLng? get latlng => _latlng;
  bool hasLatlng() => _latlng != null;

  // "nx" field.
  int? _nx;
  int get nx => _nx ?? 0;
  bool hasNx() => _nx != null;

  // "ny" field.
  int? _ny;
  int get ny => _ny ?? 0;
  bool hasNy() => _ny != null;

  // "tidObsCode" field.
  String? _tidObsCode;
  String get tidObsCode => _tidObsCode ?? '';
  bool hasTidObsCode() => _tidObsCode != null;

  // "midRegId" field.
  String? _midRegId;
  String get midRegId => _midRegId ?? '';
  bool hasMidRegId() => _midRegId != null;

  void _initializeFields() {
    _area = snapshotData['area'] as String?;
    _staCde = snapshotData['sta_cde'] as String?;
    _name = snapshotData['name'] as String?;
    _status = snapshotData['status'] as bool?;
    _latlng = snapshotData['latlng'] as LatLng?;
    _nx = castToType<int>(snapshotData['nx']);
    _ny = castToType<int>(snapshotData['ny']);
    _tidObsCode = snapshotData['tidObsCode'] as String?;
    _midRegId = snapshotData['midRegId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_weatherPoint');

  static Stream<TBWeatherPointRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBWeatherPointRecord.fromSnapshot(s));

  static Future<TBWeatherPointRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBWeatherPointRecord.fromSnapshot(s));

  static TBWeatherPointRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBWeatherPointRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBWeatherPointRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBWeatherPointRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBWeatherPointRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBWeatherPointRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBWeatherPointRecordData({
  String? area,
  String? staCde,
  String? name,
  bool? status,
  LatLng? latlng,
  int? nx,
  int? ny,
  String? tidObsCode,
  String? midRegId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'area': area,
      'sta_cde': staCde,
      'name': name,
      'status': status,
      'latlng': latlng,
      'nx': nx,
      'ny': ny,
      'tidObsCode': tidObsCode,
      'midRegId': midRegId,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBWeatherPointRecordDocumentEquality
    implements Equality<TBWeatherPointRecord> {
  const TBWeatherPointRecordDocumentEquality();

  @override
  bool equals(TBWeatherPointRecord? e1, TBWeatherPointRecord? e2) {
    return e1?.area == e2?.area &&
        e1?.staCde == e2?.staCde &&
        e1?.name == e2?.name &&
        e1?.status == e2?.status &&
        e1?.latlng == e2?.latlng &&
        e1?.nx == e2?.nx &&
        e1?.ny == e2?.ny &&
        e1?.tidObsCode == e2?.tidObsCode &&
        e1?.midRegId == e2?.midRegId;
  }

  @override
  int hash(TBWeatherPointRecord? e) => const ListEquality().hash([
        e?.area,
        e?.staCde,
        e?.name,
        e?.status,
        e?.latlng,
        e?.nx,
        e?.ny,
        e?.tidObsCode,
        e?.midRegId
      ]);

  @override
  bool isValidKey(Object? o) => o is TBWeatherPointRecord;
}
