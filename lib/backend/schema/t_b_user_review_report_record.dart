import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBUserReviewReportRecord extends FirestoreRecord{
  TBUserReviewReportRecord._(super.reference, super.data){
    _initialLizeFields();
  }

  DocumentReference? _reportedBy;
  DocumentReference? get reportedBy => _reportedBy;

  DocumentReference? _reported_post;
  DocumentReference? get reportedPost => _reported_post;

  String? _reportTitle;
  String get reportTitle => _reportTitle ?? '';

  String? _reportType;
  String get reportType => _reportType ?? '';

  _initialLizeFields(){
    _reportedBy = snapshotData['report_by'] as DocumentReference;
    _reportTitle = snapshotData['report_title'] as String?;
    _reportType = snapshotData['report_type'] as String?;
    _reported_post = snapshotData['reported_post'] as DocumentReference?;
  }

  void deleteRecord(DocumentReference reviewRef){
    reviewRef.delete();
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_userReviewReport');

  static Stream<TBUserReviewReportRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBUserReviewReportRecord.fromSnapshot(s));

  static Future<TBUserReviewReportRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBUserReviewReportRecord.fromSnapshot(s));

  static TBUserReviewReportRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBUserReviewReportRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBUserReviewReportRecord getDocumentFromData(
      Map<String, dynamic> data,
      DocumentReference reference,
      ) =>
      TBUserReviewReportRecord._(reference, mapFromFirestore(data));
}

Map<String, dynamic> createTBUserReviewReportData({
  String? reportTitle,
  String? reportType,
  DocumentReference? reportedBy,
  DocumentReference? reportedPost
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'review_title': reportTitle ?? '',
      'review_type': reportType ?? '',
      'report_by': reportedBy ?? '',
      'reported_post': reportedPost ?? '',
    }.withoutNulls,
  );

  return firestoreData;
}