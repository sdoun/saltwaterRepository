import '/flutter_flow/flutter_flow_util.dart';
import 'review_bottomsheet_widget.dart' show ReviewBottomsheetWidget;
import 'package:flutter/material.dart';

class ReviewBottomsheetModel extends FlutterFlowModel<ReviewBottomsheetWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for shortBio widget.
  FocusNode? shortBioFocusNode;
  TextEditingController? shortBioTextController;
  String? Function(BuildContext, String?)? shortBioTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    shortBioFocusNode?.dispose();
    shortBioTextController?.dispose();
  }
}
