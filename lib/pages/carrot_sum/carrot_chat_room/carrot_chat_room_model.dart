import '/flutter_flow/flutter_flow_util.dart';
import '/pages/carrot_sum/carrot_nav_bar/carrot_nav_bar_widget.dart';
import 'carrot_chat_room_widget.dart' show CarrotChatRoomWidget;
import 'package:flutter/material.dart';

class CarrotChatRoomModel extends FlutterFlowModel<CarrotChatRoomWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> chatList = [];
  void addToChatList(DocumentReference item) => chatList.add(item);
  void removeFromChatList(DocumentReference item) => chatList.remove(item);
  void removeAtIndexFromChatList(int index) => chatList.removeAt(index);
  void insertAtIndexInChatList(int index, DocumentReference item) =>
      chatList.insert(index, item);
  void updateChatListAtIndex(int index, Function(DocumentReference) updateFn) =>
      chatList[index] = updateFn(chatList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for carrotNavBar component.
  late CarrotNavBarModel carrotNavBarModel;

  @override
  void initState(BuildContext context) {
    carrotNavBarModel = createModel(context, () => CarrotNavBarModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    carrotNavBarModel.dispose();
  }
}
