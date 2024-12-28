import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home1_widget.dart' show Home1Widget;
import 'package:flutter/material.dart';

class Home1Model extends FlutterFlowModel<Home1Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for customNavbar component.
  late CustomNavbarModel customNavbarModel;
  String? searchText;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    customNavbarModel = createModel(context, () => CustomNavbarModel());
  }

  @override
  void dispose() {
    customNavbarModel.dispose();
  }
}
