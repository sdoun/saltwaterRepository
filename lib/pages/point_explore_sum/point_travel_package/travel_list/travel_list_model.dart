import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'travel_list_widget.dart' show TravelListWidget;
import 'package:flutter/material.dart';

class TravelListModel extends FlutterFlowModel<TravelListWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Bottom Sheet - package_area] action in Container widget.
  List<String>? package1stFilter;
  // Stores action output result for [Bottom Sheet - package_type] action in Container widget.
  List<String>? package2ndFilter;
  // Stores action output result for [Bottom Sheet - packageDetailed] action in Container widget.
  List<String>? package3rdFilter;
  // Stores action output result for [Custom Action - packageSearch] action in Button widget.
  List<TBTravelPackageRecord>? packages;
  // Stores action output result for [Custom Action - packageTitleSearch] action in Button widget.
  List<String>? packageTitleList;
  // Model for customNavbar component.
  late CustomNavbarModel customNavbarModel;

  /// Query cache managers for this widget.

  final _queryTestManager = StreamRequestManager<List<TBTravelPackageRecord>>();
  Stream<List<TBTravelPackageRecord>> queryTest({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TBTravelPackageRecord>> Function() requestFn,
  }) =>
      _queryTestManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearQueryTestCache() => _queryTestManager.clear();
  void clearQueryTestCacheKey(String? uniqueKey) =>
      _queryTestManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    customNavbarModel = createModel(context, () => CustomNavbarModel());
  }

  @override
  void dispose() {
    customNavbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearQueryTestCache();
  }
}
