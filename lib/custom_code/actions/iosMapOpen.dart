import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:salt_water_beta_ver1/backend/backend.dart';
import 'package:url_launcher/url_launcher.dart';

void iosMapOpen(//String address, double lat,
    TBPointRecord record) async{
  //final nMapUrl = 'nmap://search?query=$encodedAddress';
  //final kMapUrl = 'kakaomap://look?p=${record.pointLatitude},${record.pointLongitude}';
  final tMapUrl = Uri.parse('tmap://?rGoName=${record.pointName}'
      '&rGoX=${record.pointLongitude}&rGoY${record.pointLatitude}');
  final appleMapUrl = Uri.parse('http://maps.apple.com/?q=${record.pointAddress}');

  bool kakaoNavInstalled = await NaviApi.instance.isKakaoNaviInstalled();

  if(kakaoNavInstalled){
    print('kakaonav installed');
    await NaviApi.instance.navigate(destination: Location(
        name: record.pointName,
        x: record.pointLongitude as String,
        y: record.pointLatitude as String));
    //카카오 네비로 열기
  }
  else if(await canLaunchUrl(tMapUrl)){
    await launchUrl(tMapUrl, mode: LaunchMode.externalApplication);
    //tmap으로 열기
  }
  else if(await canLaunchUrl(appleMapUrl)){
    await launchUrl(appleMapUrl, mode: LaunchMode.externalApplication);
    //애플 맵으로 열기
  }
  else{
    await launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
  }
}