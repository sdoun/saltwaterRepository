import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'weather_detailed_widget.dart' show WeatherDetailedWidget;
import 'package:flutter/material.dart';

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

  int? tidDate;

  String? tidDateString;

  ///  State fields for stateful widgets in this page.

  // Model for customNavbar component.
  late CustomNavbarModel customNavbarModel;

  @override
  void initState(BuildContext context) {
    customNavbarModel = createModel(context, () => CustomNavbarModel());
  }

  @override
  void dispose() {
    customNavbarModel.dispose();
  }
}
