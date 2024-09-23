import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBProductDiscountRecord extends FirestoreRecord {
  TBProductDiscountRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "discount_percent" field.
  List<double>? _discountPercent;
  List<double> get discountPercent => _discountPercent ?? const [];
  bool hasDiscountPercent() => _discountPercent != null;

  void _initializeFields() {
    _discountPercent = getDataList(snapshotData['discount_percent']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_productDiscount');

  static Stream<TBProductDiscountRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBProductDiscountRecord.fromSnapshot(s));

  static Future<TBProductDiscountRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => TBProductDiscountRecord.fromSnapshot(s));

  static TBProductDiscountRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBProductDiscountRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBProductDiscountRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBProductDiscountRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBProductDiscountRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBProductDiscountRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBProductDiscountRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class TBProductDiscountRecordDocumentEquality
    implements Equality<TBProductDiscountRecord> {
  const TBProductDiscountRecordDocumentEquality();

  @override
  bool equals(TBProductDiscountRecord? e1, TBProductDiscountRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.discountPercent, e2?.discountPercent);
  }

  @override
  int hash(TBProductDiscountRecord? e) =>
      const ListEquality().hash([e?.discountPercent]);

  @override
  bool isValidKey(Object? o) => o is TBProductDiscountRecord;
}
