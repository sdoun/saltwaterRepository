import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBProductOptionRecord extends FirestoreRecord {
  TBProductOptionRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "option_product" field.
  DocumentReference? _optionProduct;
  DocumentReference? get optionProduct => _optionProduct;
  bool hasOptionProduct() => _optionProduct != null;

  // "option_name" field.
  String? _optionName;
  String get optionName => _optionName ?? '';
  bool hasOptionName() => _optionName != null;

  // "option_content" field.
  List<String>? _optionContent;
  List<String> get optionContent => _optionContent ?? const [];
  bool hasOptionContent() => _optionContent != null;

  // "option_price" field.
  int? _optionPrice;
  int get optionPrice => _optionPrice ?? 0;
  bool hasOptionPrice() => _optionPrice != null;

  void _initializeFields() {
    _optionProduct = snapshotData['option_product'] as DocumentReference?;
    _optionName = snapshotData['option_name'] as String?;
    _optionContent = getDataList(snapshotData['option_content']);
    _optionPrice = castToType<int>(snapshotData['option_price']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_productOption');

  static Stream<TBProductOptionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBProductOptionRecord.fromSnapshot(s));

  static Future<TBProductOptionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBProductOptionRecord.fromSnapshot(s));

  static TBProductOptionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBProductOptionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBProductOptionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBProductOptionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBProductOptionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBProductOptionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBProductOptionRecordData({
  DocumentReference? optionProduct,
  String? optionName,
  int? optionPrice,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'option_product': optionProduct,
      'option_name': optionName,
      'option_price': optionPrice,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBProductOptionRecordDocumentEquality
    implements Equality<TBProductOptionRecord> {
  const TBProductOptionRecordDocumentEquality();

  @override
  bool equals(TBProductOptionRecord? e1, TBProductOptionRecord? e2) {
    const listEquality = ListEquality();
    return e1?.optionProduct == e2?.optionProduct &&
        e1?.optionName == e2?.optionName &&
        listEquality.equals(e1?.optionContent, e2?.optionContent) &&
        e1?.optionPrice == e2?.optionPrice;
  }

  @override
  int hash(TBProductOptionRecord? e) => const ListEquality().hash(
      [e?.optionProduct, e?.optionName, e?.optionContent, e?.optionPrice]);

  @override
  bool isValidKey(Object? o) => o is TBProductOptionRecord;
}
