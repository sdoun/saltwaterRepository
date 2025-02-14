
import 'package:salt_water_beta_ver1/backend/backend.dart';

class TBFishingStoreRecord extends FirestoreRecord{

  TBFishingStoreRecord(super.reference, super.snapshotData){
    _initialLizeFields();
  }

  String _storeName = '';
  String get storeName => _storeName;

  String _storeAddresss = '';
  String get storeAddress => _storeAddresss;

  double _storeLat = 0;
  double _storeLng = 0;

  double get storeLat => _storeLat;
  double get storeLng => _storeLng;

  String _storeIntroduction = '';
  String get storeIntroduction => _storeIntroduction;

  String _storeNote = '';
  String get storeNote => _storeNote;

  List<String> _storeImages = [];
  List<String> get storeImages => _storeImages;

  List<DocumentReference> _likedBy = [];
  List<DocumentReference> get likedBy => _likedBy;

  void _initialLizeFields(){
    _storeName = snapshotData['store_name'] as String;
    _storeNote = snapshotData['store_note'] as String;
    _storeAddresss = snapshotData['store_address'] as String;
    _storeIntroduction = snapshotData['store_introduction'] as String;
    _likedBy = snapshotData['store_likedBy'] as List<DocumentReference>;
    _storeImages = snapshotData['store_images'] as List<String>;
    _storeLat = snapshotData['store_lat'] as double;
    _storeLng = snapshotData['store_lng'] as double;
  }
  static TBFishingStoreRecord fromSnapshot(DocumentSnapshot snapshot){
    return TBFishingStoreRecord(snapshot.reference, mapToFirestore(snapshot.data() as Map<String, dynamic>));
  }
}