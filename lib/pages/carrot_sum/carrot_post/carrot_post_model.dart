import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/carrot_sum/carrot_nav_bar/carrot_nav_bar_widget.dart';
import 'carrot_post_widget.dart' show CarrotPostWidget;
import 'package:flutter/material.dart';

class CarrotPostModel extends FlutterFlowModel<CarrotPostWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TBChatRoomRecord? chatRoomCreated;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  TBChatRoomRecord? chatRoomJustCreated;
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
