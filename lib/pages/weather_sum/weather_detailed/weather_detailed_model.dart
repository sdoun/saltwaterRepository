import 'package:salt_water_beta_ver1/backend/api_requests/api_manager.dart';
import 'package:salt_water_beta_ver1/models/weatherModels.dart';

import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'weather_detailed_widget.dart' show WeatherDetailedWidget;
import 'package:flutter/material.dart';
import '/flutter_flow/custom_functions.dart' as functions;

import 'package:klc/klc.dart';
import 'package:sunrise_sunset_calc/sunrise_sunset_calc.dart';

class WeatherDetailedModel extends FlutterFlowModel<WeatherDetailedWidget> {
  ///  Local state fields for this page.

  List<WeatherApiResponseStruct> obsrDataList = [];
  void addToObsrDataList(WeatherApiResponseStruct item) =>
      obsrDataList.add(item);
  void removeFromObsrDataList(WeatherApiResponseStruct item) =>
      obsrDataList.remove(item);
  void removeAtIndexFromObsrDataList(int index) => obsrDataList.removeAt(index);
  void insertAtIndexInObsrDataList(int index, WeatherApiResponseStruct item) =>
      obsrDataList.insert(index, item);
  void updateObsrDataListAtIndex(
          int index, Function(WeatherApiResponseStruct) updateFn) =>
      obsrDataList[index] = updateFn(obsrDataList[index]);

  String getLunarDate(DateTime target){
    final solar = target;
    setSolarDate(solar.year, solar.month, solar.day);
    final lunar = getLunarIsoFormat();
    print('solar is $solar , lunar is $lunar');
    return lunar;
  }

  String getWaterTime(String lunarDate){
    final days = lunarDate.substring(8,10);
    final daysInt = int.parse(days);
    int num = (daysInt + 6);
    if(num >= 15 ){
      num = num  % 15;
    }
    switch (num) {
      case 0: return '무시';
      case 1: return '$num물';
      case 2: return '$num물';
      case 3: return '$num물';
      case 4: return '$num물';
      case 5: return '$num물';
      case 6: return '$num물';
      case 7: return '$num물';
      case 8: return '$num물';
      case 9: return '$num물';
      case 10: return '$num물';
      case 11: return '$num물';
      case 12: return '$num물';
      case 13: return '$num물';
      case 14: return '조금';
    }
    return '물때';
  }

  int? tidDate;

  String? tidDateString = functions.tidDateButton(false, false, getCurrentTimestamp.toString());

  ///  State fields for stateful widgets in this page.

  // Model for customNavbar component.
  late CustomNavbarModel customNavbarModel;

  ApiCallResponse? realtimeWeatherResponse;

  ApiCallResponse? fcstWeatherResponse;

  ApiCallResponse? tidalFcstResponse;

  ApiCallResponse? midTmpResponse;

  ApiCallResponse? realtimeWtrTmpResponse;

  ApiCallResponse? midFcstResponse;

  List<SkyModel>? skyModelList;
  List<SkyModel>? tmpModelList;
  List<SkyModel>? windDirectionModelList;
  List<SkyModel> wsdModelList = [];
  List<SkyModel> pcpModelList = [];
  List<SkyModel> popModelList = [];

  @override
  void initState(BuildContext context) {
    customNavbarModel = createModel(context, () => CustomNavbarModel());
  }
  

  @override
  void dispose() {
    customNavbarModel.dispose();
  }
}
