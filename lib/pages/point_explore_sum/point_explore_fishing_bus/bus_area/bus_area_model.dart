import '/flutter_flow/flutter_flow_util.dart';
import 'bus_area_widget.dart' show BusAreaWidget;
import 'package:flutter/material.dart';

class BusAreaModel extends FlutterFlowModel<BusAreaWidget> {
  ///  Local state fields for this component.

  List<String> area = [];
  void addToArea(String item) => area.add(item);
  void removeFromArea(String item) => area.remove(item);
  void removeAtIndexFromArea(int index) => area.removeAt(index);
  void insertAtIndexInArea(int index, String item) => area.insert(index, item);
  void updateAreaAtIndex(int index, Function(String) updateFn) =>
      area[index] = updateFn(area[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
