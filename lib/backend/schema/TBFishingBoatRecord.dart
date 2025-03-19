
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salt_water_beta_ver1/backend/backend.dart';

class TBFishingBoatRecord extends FirestoreRecord{
  TBFishingBoatRecord(super.reference, super.snapshotData){
    _initialLizeFields();
  }

  String _boatName = '';
  String get boatName => _boatName;

  String _boatAddress = '';
  String get boatAddress => _boatAddress;

  String _boatIntroduction = '';
  String get boatIntroduction => _boatIntroduction;

  String _boatNote = '';
  String get boatNote => _boatNote;

  double _boatLat = 127;
  double get boatLat => _boatLat;

  double _boatLng = 37;
  double get boatLng => _boatLng;

  List<String> _boatImages = [];
  List<String> get boatImages => _boatImages;

  void _initialLizeFields(){
    _boatName = snapshotData['boat_name'] ?? '';
    _boatAddress = snapshotData['boat_address'] ?? '';
    _boatNote = snapshotData['boat_note'] ?? '';
    _boatIntroduction = snapshotData['boat_introduction'] ?? '';
    _boatLat = snapshotData['boat_latitude'] ?? 127;
    _boatLng = snapshotData['boat_longitude'] ?? 37;
    _boatImages = getDataList(snapshotData['boat_images']) ?? [];
  }

  static TBFishingBoatRecord fromSnapshot(DocumentSnapshot snapshot) => TBFishingBoatRecord(snapshot.reference, mapFromFirestore(snapshot.data() as Map<String, dynamic>));
}