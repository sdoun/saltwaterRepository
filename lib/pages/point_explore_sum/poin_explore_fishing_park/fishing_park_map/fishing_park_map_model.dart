import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import 'fishing_park_map_widget.dart' show FishingParkMapWidget;
import 'package:flutter/material.dart';

class FishingParkMapModel extends FlutterFlowModel<FishingParkMapWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Stores action output result for [Bottom Sheet - park_1stFilter] action in Container widget.
  List<String>? park1stFilter;
  // Stores action output result for [Bottom Sheet - park_2ndFilter] action in Container widget.
  List<String>? park2ndFilter;
  // Stores action output result for [Bottom Sheet - park_3rdFilter] action in Container widget.
  List<String>? park3rdFilter;
  // Stores action output result for [Custom Action - sWFilterSumString] action in Button widget.
  List<String>? pensionPointList;
  // Model for customNavbar component.
  late CustomNavbarModel customNavbarModel;

  /// Query cache managers for this widget.

  final _pointCacheManager = StreamRequestManager<List<TBPointRecord>>();
  Stream<List<TBPointRecord>> pointCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TBPointRecord>> Function() requestFn,
  }) =>
      _pointCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPointCacheCache() => _pointCacheManager.clear();
  void clearPointCacheCacheKey(String? uniqueKey) =>
      _pointCacheManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    customNavbarModel = createModel(context, () => CustomNavbarModel());
  }

  @override
  void dispose() {
    customNavbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearPointCacheCache();
  }
}
