import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TBPointRecord extends FirestoreRecord {
  TBPointRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "point_name" field.
  String? _pointName;
  String get pointName => _pointName ?? '';
  bool hasPointName() => _pointName != null;

  // "point_categories" field.
  String? _pointCategories;
  String get pointCategories => _pointCategories ?? '';
  bool hasPointCategories() => _pointCategories != null;

  // "point_latitude" field.
  double? _pointLatitude;
  double get pointLatitude => _pointLatitude ?? 0.0;
  bool hasPointLatitude() => _pointLatitude != null;

  // "point_longitude" field.
  double? _pointLongitude;
  double get pointLongitude => _pointLongitude ?? 0.0;
  bool hasPointLongitude() => _pointLongitude != null;

  // "point_imagePath" field.
  String? _pointImagePath;
  String get pointImagePath => _pointImagePath ?? '';
  bool hasPointImagePath() => _pointImagePath != null;

  // "point_tags" field.
  List<String>? _pointTags;
  List<String> get pointTags => _pointTags ?? const [];
  bool hasPointTags() => _pointTags != null;

  // "point_address" field.
  String? _pointAddress;
  String get pointAddress => _pointAddress ?? '';
  bool hasPointAddress() => _pointAddress != null;

  // "point_liked_by" field.
  List<DocumentReference>? _pointLikedBy;
  List<DocumentReference> get pointLikedBy => _pointLikedBy ?? const [];
  bool hasPointLikedBy() => _pointLikedBy != null;

  // "point_notfree" field.
  bool? _pointNotfree;
  bool get pointNotfree => _pointNotfree ?? false;
  bool hasPointNotfree() => _pointNotfree != null;

  // "point_iconpath" field.
  String? _pointIconpath;
  String get pointIconpath => _pointIconpath ?? '';
  bool hasPointIconpath() => _pointIconpath != null;

  // "point_fishing" field.
  List<String>? _pointFishing;
  List<String> get pointFishing => _pointFishing ?? const [];
  bool hasPointFishing() => _pointFishing != null;

  // "point_fishes" field.
  List<String>? _pointFishes;
  List<String> get pointFishes => _pointFishes ?? const [];
  bool hasPointFishes() => _pointFishes != null;

  // "point_involvedLink" field.
  List<String>? _pointInvolvedLink;
  List<String> get pointInvolvedLink => _pointInvolvedLink ?? const [];
  bool hasPointInvolvedLink() => _pointInvolvedLink != null;

  // "point_introduction" field.
  String? _pointIntroduction;
  String get pointIntroduction => _pointIntroduction ?? '';
  bool hasPointIntroduction() => _pointIntroduction != null;

  // "point_specialNote" field.
  String? _pointSpecialNote;
  String get pointSpecialNote => _pointSpecialNote ?? '';
  bool hasPointSpecialNote() => _pointSpecialNote != null;

  // "point_arround" field.
  String? _pointArround;
  String get pointArround => _pointArround ?? '';
  bool hasPointArround() => _pointArround != null;

  // "point_images" field.
  List<String>? _pointImages;
  List<String> get pointImages => _pointImages ?? const [];
  bool hasPointImages() => _pointImages != null;

  // "point_involvedVideo" field.
  List<String>? _pointInvolvedVideo;
  List<String> get pointInvolvedVideo => _pointInvolvedVideo ?? const [];
  bool hasPointInvolvedVideo() => _pointInvolvedVideo != null;

  void _initializeFields() {
    _pointName = snapshotData['point_name'] as String?;
    _pointCategories = snapshotData['point_categories'] as String?;
    _pointLatitude = castToType<double>(snapshotData['point_latitude']);
    _pointLongitude = castToType<double>(snapshotData['point_longitude']);
    _pointImagePath = snapshotData['point_imagePath'] as String?;
    _pointTags = getDataList(snapshotData['point_tags']);
    _pointAddress = snapshotData['point_address'] as String?;
    _pointLikedBy = getDataList(snapshotData['point_liked_by']);
    _pointNotfree = snapshotData['point_notfree'] as bool?;
    _pointIconpath = snapshotData['point_iconpath'] as String?;
    _pointFishing = getDataList(snapshotData['point_fishing']);
    _pointFishes = getDataList(snapshotData['point_fishes']);
    _pointInvolvedLink = getDataList(snapshotData['point_involvedLink']);
    _pointIntroduction = snapshotData['point_introduction'] as String?;
    _pointSpecialNote = snapshotData['point_specialNote'] as String?;
    _pointArround = snapshotData['point_arround'] as String?;
    _pointImages = getDataList(snapshotData['point_images']);
    _pointInvolvedVideo = getDataList(snapshotData['point_involvedVideo']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TB_point');

  static Stream<TBPointRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TBPointRecord.fromSnapshot(s));

  static Future<TBPointRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TBPointRecord.fromSnapshot(s));

  static TBPointRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TBPointRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TBPointRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TBPointRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TBPointRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TBPointRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTBPointRecordData({
  String? pointName,
  String? pointCategories,
  double? pointLatitude,
  double? pointLongitude,
  String? pointImagePath,
  String? pointAddress,
  bool? pointNotfree,
  String? pointIconpath,
  String? pointIntroduction,
  String? pointSpecialNote,
  String? pointArround,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'point_name': pointName,
      'point_categories': pointCategories,
      'point_latitude': pointLatitude,
      'point_longitude': pointLongitude,
      'point_imagePath': pointImagePath,
      'point_address': pointAddress,
      'point_notfree': pointNotfree,
      'point_iconpath': pointIconpath,
      'point_introduction': pointIntroduction,
      'point_specialNote': pointSpecialNote,
      'point_arround': pointArround,
    }.withoutNulls,
  );

  return firestoreData;
}

class TBPointRecordDocumentEquality implements Equality<TBPointRecord> {
  const TBPointRecordDocumentEquality();

  @override
  bool equals(TBPointRecord? e1, TBPointRecord? e2) {
    const listEquality = ListEquality();
    return e1?.pointName == e2?.pointName &&
        e1?.pointCategories == e2?.pointCategories &&
        e1?.pointLatitude == e2?.pointLatitude &&
        e1?.pointLongitude == e2?.pointLongitude &&
        e1?.pointImagePath == e2?.pointImagePath &&
        listEquality.equals(e1?.pointTags, e2?.pointTags) &&
        e1?.pointAddress == e2?.pointAddress &&
        listEquality.equals(e1?.pointLikedBy, e2?.pointLikedBy) &&
        e1?.pointNotfree == e2?.pointNotfree &&
        e1?.pointIconpath == e2?.pointIconpath &&
        listEquality.equals(e1?.pointFishing, e2?.pointFishing) &&
        listEquality.equals(e1?.pointFishes, e2?.pointFishes) &&
        listEquality.equals(e1?.pointInvolvedLink, e2?.pointInvolvedLink) &&
        e1?.pointIntroduction == e2?.pointIntroduction &&
        e1?.pointSpecialNote == e2?.pointSpecialNote &&
        e1?.pointArround == e2?.pointArround &&
        listEquality.equals(e1?.pointImages, e2?.pointImages) &&
        listEquality.equals(e1?.pointInvolvedVideo, e2?.pointInvolvedVideo);
  }

  @override
  int hash(TBPointRecord? e) => const ListEquality().hash([
        e?.pointName,
        e?.pointCategories,
        e?.pointLatitude,
        e?.pointLongitude,
        e?.pointImagePath,
        e?.pointTags,
        e?.pointAddress,
        e?.pointLikedBy,
        e?.pointNotfree,
        e?.pointIconpath,
        e?.pointFishing,
        e?.pointFishes,
        e?.pointInvolvedLink,
        e?.pointIntroduction,
        e?.pointSpecialNote,
        e?.pointArround,
        e?.pointImages,
        e?.pointInvolvedVideo
      ]);

  @override
  bool isValidKey(Object? o) => o is TBPointRecord;
}
