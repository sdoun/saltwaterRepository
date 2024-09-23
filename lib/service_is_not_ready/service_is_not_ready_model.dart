import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'service_is_not_ready_widget.dart' show ServiceIsNotReadyWidget;
import 'package:flutter/material.dart';

class ServiceIsNotReadyModel extends FlutterFlowModel<ServiceIsNotReadyWidget> {
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
