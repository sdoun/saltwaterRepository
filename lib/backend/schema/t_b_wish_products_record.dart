import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBWishProductsRecord extends FirestoreRecord {
  TBWishProductsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "productRef" field.
  DocumentReference? _productRef;
  DocumentReference? get productRef => _productRef;
  bool hasProductRef() => _productRef != null;

  // "productNum" field.
  int? _productNum;
  int get productNum => _productNum ?? 0;
  bool hasProductNum() => _productNum != null;

  // "wish_option" field.
  List<String>? _wishOption;
  List<String> get wishOption => _wishOption ?? const [];
  bool hasWishOption() => _wishOption != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _productRef = snapshotData['productRef'] as DocumentReference?;
    _productNum = castToType<int>(snapshotData['productNum']);
    _wishOption = getDataList(snapshotData['wish_option']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_wishProducts');

  static Stream<TBWishProductsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBWishProductsRecord.fromSnapshot(s));

  static Future<TBWishProductsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBWishProductsRecord.fromSnapshot(s));

  static TBWishProductsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBWishProductsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBWishProductsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBWishProductsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBWishProductsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBWishProductsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBWishProductsRecordData({
  DocumentReference? userRef,
  DocumentReference? productRef,
  int? productNum,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'productRef': productRef,
      'productNum': productNum,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBWishProductsRecordDocumentEquality
    implements Equality<TBWishProductsRecord> {
  const TBWishProductsRecordDocumentEquality();

  @override
  bool equals(TBWishProductsRecord? e1, TBWishProductsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        e1?.productRef == e2?.productRef &&
        e1?.productNum == e2?.productNum &&
        listEquality.equals(e1?.wishOption, e2?.wishOption);
  }

  @override
  int hash(TBWishProductsRecord? e) => const ListEquality()
      .hash([e?.userRef, e?.productRef, e?.productNum, e?.wishOption]);

  @override
  bool isValidKey(Object? o) => o is TBWishProductsRecord;
}
