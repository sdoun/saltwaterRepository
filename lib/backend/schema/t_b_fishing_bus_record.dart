import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBFishingBusRecord extends FirestoreRecord {
  TBFishingBusRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "bus_name" field.
  String? _busName;
  String get busName => _busName ?? '';
  bool hasBusName() => _busName != null;

  // "bus_image" field.
  String? _busImage;
  String get busImage => _busImage ?? '';
  bool hasBusImage() => _busImage != null;

  // "bus_noti" field.
  String? _busNoti;
  String get busNoti => _busNoti ?? '';
  bool hasBusNoti() => _busNoti != null;

  // "bus_area" field.
  String? _busArea;
  String get busArea => _busArea ?? '';
  bool hasBusArea() => _busArea != null;

  // "bus_date" field.
  DateTime? _busDate;
  DateTime? get busDate => _busDate;
  bool hasBusDate() => _busDate != null;

  // "bus_timeOfUse" field.
  double? _busTimeOfUse;
  double get busTimeOfUse => _busTimeOfUse ?? 0.0;
  bool hasBusTimeOfUse() => _busTimeOfUse != null;

  // "bus_fishes" field.
  List<String>? _busFishes;
  List<String> get busFishes => _busFishes ?? const [];
  bool hasBusFishes() => _busFishes != null;

  // "bus_fishing" field.
  List<String>? _busFishing;
  List<String> get busFishing => _busFishing ?? const [];
  bool hasBusFishing() => _busFishing != null;

  // "bus_payment" field.
  List<String>? _busPayment;
  List<String> get busPayment => _busPayment ?? const [];
  bool hasBusPayment() => _busPayment != null;

  void _initializeFields() {
    _busName = snapshotData['bus_name'] as String?;
    _busImage = snapshotData['bus_image'] as String?;
    _busNoti = snapshotData['bus_noti'] as String?;
    _busArea = snapshotData['bus_area'] as String?;
    _busDate = snapshotData['bus_date'] as DateTime?;
    _busTimeOfUse = castToType<double>(snapshotData['bus_timeOfUse']);
    _busFishes = getDataList(snapshotData['bus_fishes']);
    _busFishing = getDataList(snapshotData['bus_fishing']);
    _busPayment = getDataList(snapshotData['bus_payment']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_fishingBus');

  static Stream<TBFishingBusRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBFishingBusRecord.fromSnapshot(s));

  static Future<TBFishingBusRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBFishingBusRecord.fromSnapshot(s));

  static TBFishingBusRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBFishingBusRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBFishingBusRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBFishingBusRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBFishingBusRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBFishingBusRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBFishingBusRecordData({
  String? busName,
  String? busImage,
  String? busNoti,
  String? busArea,
  DateTime? busDate,
  double? busTimeOfUse,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bus_name': busName,
      'bus_image': busImage,
      'bus_noti': busNoti,
      'bus_area': busArea,
      'bus_date': busDate,
      'bus_timeOfUse': busTimeOfUse,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBFishingBusRecordDocumentEquality
    implements Equality<TBFishingBusRecord> {
  const TBFishingBusRecordDocumentEquality();

  @override
  bool equals(TBFishingBusRecord? e1, TBFishingBusRecord? e2) {
    const listEquality = ListEquality();
    return e1?.busName == e2?.busName &&
        e1?.busImage == e2?.busImage &&
        e1?.busNoti == e2?.busNoti &&
        e1?.busArea == e2?.busArea &&
        e1?.busDate == e2?.busDate &&
        e1?.busTimeOfUse == e2?.busTimeOfUse &&
        listEquality.equals(e1?.busFishes, e2?.busFishes) &&
        listEquality.equals(e1?.busFishing, e2?.busFishing) &&
        listEquality.equals(e1?.busPayment, e2?.busPayment);
  }

  @override
  int hash(TBFishingBusRecord? e) => const ListEquality().hash([
        e?.busName,
        e?.busImage,
        e?.busNoti,
        e?.busArea,
        e?.busDate,
        e?.busTimeOfUse,
        e?.busFishes,
        e?.busFishing,
        e?.busPayment
      ]);

  @override
  bool isValidKey(Object? o) => o is TBFishingBusRecord;
}
