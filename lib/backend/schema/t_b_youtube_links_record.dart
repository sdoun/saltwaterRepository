import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBYoutubeLinksRecord extends FirestoreRecord {
  TBYoutubeLinksRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "videoName" field.
  String? _videoName;
  String get videoName => _videoName ?? '';
  bool hasVideoName() => _videoName != null;

  // "youtubeLInk" field.
  String? _youtubeLInk;
  String get youtubeLInk => _youtubeLInk ?? '';
  bool hasYoutubeLInk() => _youtubeLInk != null;

  // "videoLink" field.
  String? _videoLink;
  String get videoLink => _videoLink ?? '';
  bool hasVideoLink() => _videoLink != null;

  void _initializeFields() {
    _videoName = snapshotData['videoName'] as String?;
    _youtubeLInk = snapshotData['youtubeLInk'] as String?;
    _videoLink = snapshotData['videoLink'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_youtubeLinks');

  static Stream<TBYoutubeLinksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBYoutubeLinksRecord.fromSnapshot(s));

  static Future<TBYoutubeLinksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBYoutubeLinksRecord.fromSnapshot(s));

  static TBYoutubeLinksRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBYoutubeLinksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBYoutubeLinksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBYoutubeLinksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBYoutubeLinksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBYoutubeLinksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBYoutubeLinksRecordData({
  String? videoName,
  String? youtubeLInk,
  String? videoLink,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'videoName': videoName,
      'youtubeLInk': youtubeLInk,
      'videoLink': videoLink,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBYoutubeLinksRecordDocumentEquality
    implements Equality<TBYoutubeLinksRecord> {
  const TBYoutubeLinksRecordDocumentEquality();

  @override
  bool equals(TBYoutubeLinksRecord? e1, TBYoutubeLinksRecord? e2) {
    return e1?.videoName == e2?.videoName &&
        e1?.youtubeLInk == e2?.youtubeLInk &&
        e1?.videoLink == e2?.videoLink;
  }

  @override
  int hash(TBYoutubeLinksRecord? e) =>
      const ListEquality().hash([e?.videoName, e?.youtubeLInk, e?.videoLink]);

  @override
  bool isValidKey(Object? o) => o is TBYoutubeLinksRecord;
}
