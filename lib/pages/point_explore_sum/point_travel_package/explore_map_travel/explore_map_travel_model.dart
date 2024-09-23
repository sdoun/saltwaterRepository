import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'explore_map_travel_widget.dart' show ExploreMapTravelWidget;
import 'package:flutter/material.dart';

class ExploreMapTravelModel extends FlutterFlowModel<ExploreMapTravelWidget> {
  ///  State fields for stateful widgets in this page.

  List<TBPointRecord>? exploreMapTravelPreviousSnapshot;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // Stores action output result for [Bottom Sheet - package_area] action in Container widget.
  List<String>? package1stFilter;
  // Stores action output result for [Bottom Sheet - ocean_2ndFilter] action in Container widget.
  List<String>? ocean2ndFilter;
  // Stores action output result for [Bottom Sheet - seawall_3rdFilter] action in Container widget.
  List<String>? oceean3rdFilter;
  // Model for customNavbar component.
  late CustomNavbarModel customNavbarModel;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    rowController = ScrollController();
    customNavbarModel = createModel(context, () => CustomNavbarModel());
  }

  @override
  void dispose() {
    columnController?.dispose();
    rowController?.dispose();
    customNavbarModel.dispose();
  }
}
