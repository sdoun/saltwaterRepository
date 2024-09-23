import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBServiceTermsRecord extends FirestoreRecord {
  TBServiceTermsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "terms_title" field.
  String? _termsTitle;
  String get termsTitle => _termsTitle ?? '';
  bool hasTermsTitle() => _termsTitle != null;

  // "terms_content" field.
  String? _termsContent;
  String get termsContent => _termsContent ?? '';
  bool hasTermsContent() => _termsContent != null;

  void _initializeFields() {
    _termsTitle = snapshotData['terms_title'] as String?;
    _termsContent = snapshotData['terms_content'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_serviceTerms');

  static Stream<TBServiceTermsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBServiceTermsRecord.fromSnapshot(s));

  static Future<TBServiceTermsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBServiceTermsRecord.fromSnapshot(s));

  static TBServiceTermsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBServiceTermsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBServiceTermsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBServiceTermsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBServiceTermsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBServiceTermsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBServiceTermsRecordData({
  String? termsTitle,
  String? termsContent,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'terms_title': termsTitle,
      'terms_content': termsContent,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBServiceTermsRecordDocumentEquality
    implements Equality<TBServiceTermsRecord> {
  const TBServiceTermsRecordDocumentEquality();

  @override
  bool equals(TBServiceTermsRecord? e1, TBServiceTermsRecord? e2) {
    return e1?.termsTitle == e2?.termsTitle &&
        e1?.termsContent == e2?.termsContent;
  }

  @override
  int hash(TBServiceTermsRecord? e) =>
      const ListEquality().hash([e?.termsTitle, e?.termsContent]);

  @override
  bool isValidKey(Object? o) => o is TBServiceTermsRecord;
}
