import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'fishing_bus_map_widget.dart' show FishingBusMapWidget;
import 'package:flutter/material.dart';

class FishingBusMapModel extends FlutterFlowModel<FishingBusMapWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Bottom Sheet - busFishes] action in Container widget.
  List<String>? selectedFishes;
  // Stores action output result for [Custom Action - busSearch] action in Button widget.
  List<TBFishingBusRecord>? busSearchList;
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
