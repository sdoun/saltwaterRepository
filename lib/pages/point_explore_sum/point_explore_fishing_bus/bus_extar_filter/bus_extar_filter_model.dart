import '/flutter_flow/flutter_flow_util.dart';
import 'bus_extar_filter_widget.dart' show BusExtarFilterWidget;
import 'package:flutter/material.dart';

class BusExtarFilterModel extends FlutterFlowModel<BusExtarFilterWidget> {
  ///  Local state fields for this component.

  List<String> extraFilter = [];
  void addToExtraFilter(String item) => extraFilter.add(item);
  void removeFromExtraFilter(String item) => extraFilter.remove(item);
  void removeAtIndexFromExtraFilter(int index) => extraFilter.removeAt(index);
  void insertAtIndexInExtraFilter(int index, String item) =>
      extraFilter.insert(index, item);
  void updateExtraFilterAtIndex(int index, Function(String) updateFn) =>
      extraFilter[index] = updateFn(extraFilter[index]);

  List<String> tiemOfUse = [];
  void addToTiemOfUse(String item) => tiemOfUse.add(item);
  void removeFromTiemOfUse(String item) => tiemOfUse.remove(item);
  void removeAtIndexFromTiemOfUse(int index) => tiemOfUse.removeAt(index);
  void insertAtIndexInTiemOfUse(int index, String item) =>
      tiemOfUse.insert(index, item);
  void updateTiemOfUseAtIndex(int index, Function(String) updateFn) =>
      tiemOfUse[index] = updateFn(tiemOfUse[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
