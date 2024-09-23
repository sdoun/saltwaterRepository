import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'fishing_bus_list_widget.dart' show FishingBusListWidget;
import 'package:flutter/material.dart';

class FishingBusListModel extends FlutterFlowModel<FishingBusListWidget> {
  ///  Local state fields for this page.

  List<String> filterFishes = [];
  void addToFilterFishes(String item) => filterFishes.add(item);
  void removeFromFilterFishes(String item) => filterFishes.remove(item);
  void removeAtIndexFromFilterFishes(int index) => filterFishes.removeAt(index);
  void insertAtIndexInFilterFishes(int index, String item) =>
      filterFishes.insert(index, item);
  void updateFilterFishesAtIndex(int index, Function(String) updateFn) =>
      filterFishes[index] = updateFn(filterFishes[index]);

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
