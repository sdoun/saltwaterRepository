
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salt_water_beta_ver1/backend/schema/util/firestore_util.dart';

class TBReviewCommentRecord extends FirestoreRecord{
  TBReviewCommentRecord(super.reference, super.snapshotData){
    _initialLizeField();
  }

  static TBReviewCommentRecord fromSnapshot(DocumentSnapshot snapshot){
    return TBReviewCommentRecord(snapshot.reference, mapToFirestore(snapshot.data() as Map<String, dynamic>));
  }

  String _content = '';
  String get content => _content;

  DocumentReference? _reviewRef;
  DocumentReference? get reviewRef => _reviewRef;

  DocumentReference? _writtenBy;
  DocumentReference? get writtenBy => _writtenBy;

  void _initialLizeField(){
    _content = snapshotData['comment_content'] ?? _content;
    _reviewRef = snapshotData['comment_review'];
    _writtenBy = snapshotData['comment_writer'];
  }

  static DocumentReference createId({String? id}) =>
      FirebaseFirestore.instance.collection('TB_review_comments').doc(id);

  static Future<DocumentReference> createDoc(
      DocumentReference writtenBy,
      String content,
      DocumentReference review
      ) async{
    DocumentReference newId = createId();
    newId.set({
      'comment_content': content,
      'comment_writer' : writtenBy,
      'comment_review' : review
    });
    return newId;
  }

  static Stream<TBReviewCommentRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBReviewCommentRecord.fromSnapshot(s));

  static Future<TBReviewCommentRecord> getDocumentOnce(
      DocumentReference ref) =>
      ref.get().then((s) => TBReviewCommentRecord.fromSnapshot(s));
}