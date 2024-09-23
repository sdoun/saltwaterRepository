import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'explore_map_fishing_pension_widget.dart'
    show ExploreMapFishingPensionWidget;
import 'package:flutter/material.dart';

class ExploreMapFishingPensionModel
    extends FlutterFlowModel<ExploreMapFishingPensionWidget> {
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

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Stores action output result for [Bottom Sheet - pension_1stFilter] action in Container widget.
  List<String>? pension1stFilter;
  // Stores action output result for [Bottom Sheet - pension_2ndFilter] action in Container widget.
  List<String>? pension2ndFilter;
  // Stores action output result for [Bottom Sheet - pension_3rdFilter] action in Container widget.
  List<String>? pension3rdFilter;
  // Stores action output result for [Custom Action - sWFilterSumString] action in Button widget.
  List<String>? pensionPointList;
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
