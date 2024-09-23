import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'agreement_for_sign_in_widget.dart' show AgreementForSignInWidget;
import 'package:flutter/material.dart';

class AgreementForSignInModel
    extends FlutterFlowModel<AgreementForSignInWidget> {
  ///  Local state fields for this component.

  bool serviceTerm = false;

  bool personalData = false;

  bool phoneAuth = false;

  bool geoBased = false;

  bool marketing = false;

  ///  State fields for stateful widgets in this component.

  List<TBServiceTermsRecord>? containerPreviousSnapshot;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
