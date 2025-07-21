
import 'package:salt_water_beta_ver1/backend/backend.dart';

class TBPointThemeRecord extends FirestoreRecord{

  TBPointThemeRecord(super.reference, super.snapshotData){
    initializeField();
  }

    String? _themeName = '';
    String? get themeName => _themeName;

    String _themeImagePath = '';
    String get themeImagePath => _themeImagePath;

    String _themeDesc = '';
    String get themeDesc => _themeDesc;

    List<String> _themeDescImagePath = [];
    List<String> get themeDescImage => _themeDescImagePath;

    bool _themeActive = false;
    bool get themeActive => _themeActive;

    void initializeField(){
      _themeName = snapshotData['theme_name'] as String?;
      _themeImagePath = snapshotData['theme_image'] as String;
      _themeActive = snapshotData['theme_active'] as bool;
      _themeDescImagePath = getDataList(snapshotData['theme_desc_images']) ?? [];
      _themeDesc = snapshotData['theme_desc'] as String? ?? _themeDesc;
    }

    static TBPointThemeRecord fromSnapshot(DocumentSnapshot snapshot)
    => TBPointThemeRecord(snapshot.reference, mapToFirestore(snapshot.data() as Map<String, dynamic>));

}