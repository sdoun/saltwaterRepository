
import 'package:salt_water_beta_ver1/backend/backend.dart';

class TBPointThemeRecord extends FirestoreRecord{

  TBPointThemeRecord(super.reference, super.snapshotData){
    initializeField();
  }

    String? _themeName = '';
    String? get themeName => _themeName;

    String _themeImagePath = '';
    String get themeImagePath => _themeImagePath;

    bool _themeActive = false;
    bool get themeActive => _themeActive;

    void initializeField(){
      _themeName = snapshotData['theme_name'] as String?;
      _themeImagePath = snapshotData['theme_image'] as String;
      _themeActive = snapshotData['theme_active'] as bool;
    }

    static TBPointThemeRecord fromSnapshot(DocumentSnapshot snapshot)
    => TBPointThemeRecord(snapshot.reference, mapToFirestore(snapshot.data() as Map<String, dynamic>));

}