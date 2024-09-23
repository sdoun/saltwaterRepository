import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'explore_map_ocean_widget.dart' show ExploreMapOceanWidget;
import 'package:flutter/material.dart';

class ExploreMapOceanModel extends FlutterFlowModel<ExploreMapOceanWidget> {
  ///  Local state fields for this page.

  List<TBPointRecord> filterValue = [];
  void addToFilterValue(TBPointRecord item) => filterValue.add(item);
  void removeFromFilterValue(TBPointRecord item) => filterValue.remove(item);
  void removeAtIndexFromFilterValue(int index) => filterValue.removeAt(index);
  void insertAtIndexInFilterValue(int index, TBPointRecord item) =>
      filterValue.insert(index, item);
  void updateFilterValueAtIndex(int index, Function(TBPointRecord) updateFn) =>
      filterValue[index] = updateFn(filterValue[index]);

  ///  State fields for stateful widgets in this page.

  List<TBPointRecord>? exploreMapOceanPreviousSnapshot;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // Stores action output result for [Bottom Sheet - ocean_1stFilter] action in Container widget.
  List<String>? ocean1stFilter;
  // Stores action output result for [Bottom Sheet - ocean_2ndFilter] action in Container widget.
  List<String>? ocean2ndFilter;
  // Stores action output result for [Bottom Sheet - seawall_3rdFilter] action in Container widget.
  List<String>? oceean3rdFilter;
  // Stores action output result for [Custom Action - pointListFromFilter] action in Button widget.
  List<String>? pointList;
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
