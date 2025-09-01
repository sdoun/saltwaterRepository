import 'dart:math';

import 'package:salt_water_beta_ver1/backend/backend.dart';

class TBniceFishingRecord extends FirestoreRecord{

  TBniceFishingRecord(super.reference, super.snapshotData){
    initializeField();
  }

  String? _fishingName = '';
  String? get themeName => _fishingName;

  String _fishingImagePath = '';
  String get themeImagePath =>  _fishingImagePath;


  int _fishingNum = Random().nextInt(20);
  int get fishingNum => _fishingNum;

  String _themeDesc = '';
  String get themeDesc => _themeDesc;

  List<String> _themeDescImagePath = [];
  List<String> get themeDescImage => _themeDescImagePath;

  bool _themeActive = false;
  bool get themeActive => _themeActive;

  void initializeField(){
    _fishingName = snapshotData['name'] as String?;
    _fishingImagePath = snapshotData['image'] as String;
    _fishingNum = snapshotData['fishing_num'] as int;
    _themeActive = snapshotData['active'] as bool;
    _themeDescImagePath = getDataList(snapshotData['desc_images']) ?? [];
    _themeDesc = snapshotData['desc_text'] as String? ?? _themeDesc;
  }

  static TBniceFishingRecord fromSnapshot(DocumentSnapshot snapshot)
  => TBniceFishingRecord(snapshot.reference, mapToFirestore(snapshot.data() as Map<String, dynamic>));

}