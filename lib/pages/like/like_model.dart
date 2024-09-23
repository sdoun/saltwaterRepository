import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'like_widget.dart' show LikeWidget;
import 'package:flutter/material.dart';

class LikeModel extends FlutterFlowModel<LikeWidget> {
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
