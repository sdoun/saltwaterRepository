import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBCarrotPostRecord extends FirestoreRecord {
  TBCarrotPostRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "post_title" field.
  String? _postTitle;
  String get postTitle => _postTitle ?? '';
  bool hasPostTitle() => _postTitle != null;

  // "post_content" field.
  String? _postContent;
  String get postContent => _postContent ?? '';
  bool hasPostContent() => _postContent != null;

  // "post_image" field.
  List<String>? _postImage;
  List<String> get postImage => _postImage ?? const [];
  bool hasPostImage() => _postImage != null;

  // "post_datetime" field.
  DateTime? _postDatetime;
  DateTime? get postDatetime => _postDatetime;
  bool hasPostDatetime() => _postDatetime != null;

  // "post_status" field.
  String? _postStatus;
  String get postStatus => _postStatus ?? '';
  bool hasPostStatus() => _postStatus != null;

  // "post_price" field.
  int? _postPrice;
  int get postPrice => _postPrice ?? 0;
  bool hasPostPrice() => _postPrice != null;

  // "post_category" field.
  String? _postCategory;
  String get postCategory => _postCategory ?? '';
  bool hasPostCategory() => _postCategory != null;

  // "post_likedBy" field.
  List<DocumentReference>? _postLikedBy;
  List<DocumentReference> get postLikedBy => _postLikedBy ?? const [];
  bool hasPostLikedBy() => _postLikedBy != null;

  // "post_seller" field.
  DocumentReference? _postSeller;
  DocumentReference? get postSeller => _postSeller;
  bool hasPostSeller() => _postSeller != null;

  void _initializeFields() {
    _postTitle = snapshotData['post_title'] as String?;
    _postContent = snapshotData['post_content'] as String?;
    _postImage = getDataList(snapshotData['post_image']);
    _postDatetime = snapshotData['post_datetime'] as DateTime?;
    _postStatus = snapshotData['post_status'] as String?;
    _postPrice = castToType<int>(snapshotData['post_price']);
    _postCategory = snapshotData['post_category'] as String?;
    _postLikedBy = getDataList(snapshotData['post_likedBy']);
    _postSeller = snapshotData['post_seller'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_carrotPost');

  static Stream<TBCarrotPostRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBCarrotPostRecord.fromSnapshot(s));

  static Future<TBCarrotPostRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBCarrotPostRecord.fromSnapshot(s));

  static TBCarrotPostRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBCarrotPostRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBCarrotPostRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBCarrotPostRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBCarrotPostRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBCarrotPostRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBCarrotPostRecordData({
  String? postTitle,
  String? postContent,
  DateTime? postDatetime,
  String? postStatus,
  int? postPrice,
  String? postCategory,
  DocumentReference? postSeller,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'post_title': postTitle,
      'post_content': postContent,
      'post_datetime': postDatetime,
      'post_status': postStatus,
      'post_price': postPrice,
      'post_category': postCategory,
      'post_seller': postSeller,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBCarrotPostRecordDocumentEquality
    implements Equality<TBCarrotPostRecord> {
  const TBCarrotPostRecordDocumentEquality();

  @override
  bool equals(TBCarrotPostRecord? e1, TBCarrotPostRecord? e2) {
    const listEquality = ListEquality();
    return e1?.postTitle == e2?.postTitle &&
        e1?.postContent == e2?.postContent &&
        listEquality.equals(e1?.postImage, e2?.postImage) &&
        e1?.postDatetime == e2?.postDatetime &&
        e1?.postStatus == e2?.postStatus &&
        e1?.postPrice == e2?.postPrice &&
        e1?.postCategory == e2?.postCategory &&
        listEquality.equals(e1?.postLikedBy, e2?.postLikedBy) &&
        e1?.postSeller == e2?.postSeller;
  }

  @override
  int hash(TBCarrotPostRecord? e) => const ListEquality().hash([
        e?.postTitle,
        e?.postContent,
        e?.postImage,
        e?.postDatetime,
        e?.postStatus,
        e?.postPrice,
        e?.postCategory,
        e?.postLikedBy,
        e?.postSeller
      ]);

  @override
  bool isValidKey(Object? o) => o is TBCarrotPostRecord;
}
