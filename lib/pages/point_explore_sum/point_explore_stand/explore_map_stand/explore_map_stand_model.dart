import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'explore_map_stand_widget.dart' show ExploreMapStandWidget;
import 'package:flutter/material.dart';

class ExploreMapStandModel extends FlutterFlowModel<ExploreMapStandWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Stores action output result for [Bottom Sheet - stand_1stFilter] action in Container widget.
  List<String>? stand1stFilter;
  // Stores action output result for [Bottom Sheet - stnad_2ndFilter] action in Container widget.
  List<String>? stand2ndFilter;
  // Stores action output result for [Bottom Sheet - stand_3rdFilter] action in Container widget.
  List<String>? stand3rdFilter;
  // Stores action output result for [Custom Action - standListFromFilter] action in Button widget.
  List<String>? standList;
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
