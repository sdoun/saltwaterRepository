import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBUserReviewPointRecord extends FirestoreRecord {
  TBUserReviewPointRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "review_title" field.
  String? _reviewTitle;
  String get reviewTitle => _reviewTitle ?? '';
  bool hasReviewTitle() => _reviewTitle != null;

  // "review_written_by" field.
  DocumentReference? _reviewWrittenBy;
  DocumentReference? get reviewWrittenBy => _reviewWrittenBy;
  bool hasReviewWrittenBy() => _reviewWrittenBy != null;

  // "review_text" field.
  String? _reviewText;
  String get reviewText => _reviewText ?? '';
  bool hasReviewText() => _reviewText != null;

  // "review_pointRef" field.
  DocumentReference? _reviewPointRef;
  DocumentReference? get reviewPointRef => _reviewPointRef;
  bool hasReviewPointRef() => _reviewPointRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _reviewTitle = snapshotData['review_title'] as String?;
    _reviewWrittenBy = snapshotData['review_written_by'] as DocumentReference?;
    _reviewText = snapshotData['review_text'] as String?;
    _reviewPointRef = snapshotData['review_pointRef'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('TB_userReview_point')
          : FirebaseFirestore.instance.collectionGroup('TB_userReview_point');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('TB_userReview_point').doc(id);

  static Stream<TBUserReviewPointRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBUserReviewPointRecord.fromSnapshot(s));

  static Future<TBUserReviewPointRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => TBUserReviewPointRecord.fromSnapshot(s));

  static TBUserReviewPointRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBUserReviewPointRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBUserReviewPointRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBUserReviewPointRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBUserReviewPointRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBUserReviewPointRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBUserReviewPointRecordData({
  String? reviewTitle,
  DocumentReference? reviewWrittenBy,
  String? reviewText,
  DocumentReference? reviewPointRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'review_title': reviewTitle,
      'review_written_by': reviewWrittenBy,
      'review_text': reviewText,
      'review_pointRef': reviewPointRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBUserReviewPointRecordDocumentEquality
    implements Equality<TBUserReviewPointRecord> {
  const TBUserReviewPointRecordDocumentEquality();

  @override
  bool equals(TBUserReviewPointRecord? e1, TBUserReviewPointRecord? e2) {
    return e1?.reviewTitle == e2?.reviewTitle &&
        e1?.reviewWrittenBy == e2?.reviewWrittenBy &&
        e1?.reviewText == e2?.reviewText &&
        e1?.reviewPointRef == e2?.reviewPointRef;
  }

  @override
  int hash(TBUserReviewPointRecord? e) => const ListEquality().hash(
      [e?.reviewTitle, e?.reviewWrittenBy, e?.reviewText, e?.reviewPointRef]);

  @override
  bool isValidKey(Object? o) => o is TBUserReviewPointRecord;
}
