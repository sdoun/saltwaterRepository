import '/flutter_flow/flutter_flow_util.dart';
import '/pages/carrot_sum/carrot_nav_bar/carrot_nav_bar_widget.dart';
import 'carrot_home_widget.dart' show CarrotHomeWidget;
import 'package:flutter/material.dart';

class CarrotHomeModel extends FlutterFlowModel<CarrotHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for carrotNavBar component.
  late CarrotNavBarModel carrotNavBarModel;

  @override
  void initState(BuildContext context) {
    carrotNavBarModel = createModel(context, () => CarrotNavBarModel());
  }

  @override
  void dispose() {
    carrotNavBarModel.dispose();
  }
}
