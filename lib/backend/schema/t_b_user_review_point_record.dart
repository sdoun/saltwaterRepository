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

  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;

  List<String> _reviewImages = [];
  List<String> get reviewImages => _reviewImages;


  List<DocumentReference>? _reviewReportedBy = [];
  List<DocumentReference> get reviewReportedBy => _reviewReportedBy ?? [];
  bool hasReviewReported() => _reviewReportedBy != null || _reviewReportedBy!.isEmpty;

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
    _reviewReportedBy = getDataList(snapshotData['reported_by']);
    _timestamp = snapshotData['timestamp'];
    _reviewImages = getDataList(snapshotData['review_images']) ?? [
      'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%88%98%EC%A0%95%ED%8E%98%EC%9D%B4%EC%A7%80%2F%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%9D%B4%EB%AF%B8%EC%A7%80%EC%97%86%EC%9D%8C.png?alt=media&token=b357c611-3df0-4134-bf83-6d72fa96b82e'
    ];
  }

  void deleteRecord(DocumentReference reviewRef){
    reviewRef.delete();
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

  static TBUserReviewPointRecord fromSnapshot(DocumentSnapshot snapshot){
    //print('snapshot to fromsnapshot ${snapshot}');
    return TBUserReviewPointRecord._(
      snapshot.reference,
      mapFromFirestore(snapshot.data() as Map<String, dynamic>),
    );
  }

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
  Timestamp? timestamp,
  List<String>? reviewImages
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'review_title': reviewTitle,
      'review_written_by': reviewWrittenBy,
      'review_text': reviewText,
      'review_pointRef': reviewPointRef,
      'timestamp':timestamp,
      'review_images':reviewImages
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
