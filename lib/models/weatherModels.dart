import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

class WeatherModel{
  late String fcstDate;
  late String fcstTime;
  late double fcstValue;

}

class SkyModel{
  final String fcstDate;
  final String fcstTime;
  String fcstValue;
  late int itemNum;

  SkyModel.fromJson(Map<String, dynamic> json)
  : fcstDate = json['fcstDate'],
    fcstTime = json['fcstTime'],
    fcstValue = json['fcstValue'];

  static List<SkyModel> createSkyList(Map<String, dynamic>? data){
    List<SkyModel> result = [];
    var dataList = getJsonField(data, r'$.response.body.items.item') as List? ?? [];
    if(data != null){
      for(Map<String, dynamic> item in dataList){
        if(item['category'] == 'SKY'){
          final skyItem = SkyModel.fromJson(item);
          result.add(skyItem);
          skyItem.fcstTime.substring(0,2);
        }
      }
    }
    return result;
  }
  static List<SkyModel> createTmpList(Map<String, dynamic>? data){
    List<SkyModel> result = [];
    var dataList = getJsonField(data, r'$.response.body.items.item') as List? ?? [];
    if(data != null){
      int i = 0;
      for(Map<String, dynamic> item in dataList){

        if(item['category'] == 'TMP'){
          final skyItem = SkyModel.fromJson(item);
          print('TMP is $skyItem.fcstValue');
          result.add(skyItem);
          skyItem.fcstTime.substring(0,2);
          skyItem.itemNum = i;
          i++;
        }
      }
    }
    return result;
  }
  static List<SkyModel> createWindDirectionList(Map<String, dynamic>? data){
    List<SkyModel> result = [];
    var dataList = getJsonField(data, r'$.response.body.items.item') as List? ?? [];
    if(data != null){
      for(Map<String, dynamic> item in dataList){
        if(item['category'] == 'VEC'){
          final skyItem = SkyModel.fromJson(item);
          result.add(skyItem);
          skyItem.fcstTime.substring(0,2);
        }
      }
    }
    return result;
  }
  static List<SkyModel> createWsdList(Map<String, dynamic>? data){
    List<SkyModel> result = [];
    var dataList = getJsonField(data, r'$.response.body.items.item') as List? ?? [];
    if(data != null){
      int i = 0;
      for(Map<String, dynamic> item in dataList){

        if(item['category'] == 'WSD'){
          final skyItem = SkyModel.fromJson(item);
          print('TMP is $skyItem.fcstValue');
          result.add(skyItem);
          skyItem.fcstTime.substring(0,2);
          skyItem.itemNum = i;
          i++;
        }
      }
    }
    return result;
  }
  static List<SkyModel> createPcpList(Map<String, dynamic>? data){
    List<SkyModel> result = [];
    var dataList = getJsonField(data, r'$.response.body.items.item') as List? ?? [];
    if(data != null){
      int i = 0;
      for(Map<String, dynamic> item in dataList){

        if(item['category'] == 'PCP'){
          final skyItem = SkyModel.fromJson(item);
          if(skyItem.fcstValue == '강수없음'){
            skyItem.fcstValue = '0mm';
          }
          if(skyItem.fcstValue.contains('mm')){
            skyItem.fcstValue = skyItem.fcstValue.split('m')[0];
            print('TMP is ${skyItem.fcstValue}');
          }

          result.add(skyItem);
          skyItem.fcstTime.substring(0,2);
          skyItem.itemNum = i;
          i++;
        }
      }
    }
    return result;
  }
  static List<SkyModel> createPopList(Map<String, dynamic>? data){
    List<SkyModel> result = [];
    var dataList = getJsonField(data, r'$.response.body.items.item') as List? ?? [];
    if(data != null){
      int i = 0;
      for(Map<String, dynamic> item in dataList){

        if(item['category'] == 'POP'){
          final skyItem = SkyModel.fromJson(item);

          result.add(skyItem);
          skyItem.fcstTime.substring(0,2);
          skyItem.itemNum = i;
          i++;
        }
      }
    }
    return result;
  }
}