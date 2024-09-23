import '/flutter_flow/flutter_flow_util.dart';
import '/pages/shop_summary/product_detail/option_dropdown/option_dropdown_widget.dart';
import 'add_product_to_wish_widget.dart' show AddProductToWishWidget;
import 'package:flutter/material.dart';

class AddProductToWishModel extends FlutterFlowModel<AddProductToWishWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for optionDropdown dynamic component.
  late FlutterFlowDynamicModels<OptionDropdownModel> optionDropdownModels;
  // State field(s) for CountController widget.
  int? countControllerValue;

  @override
  void initState(BuildContext context) {
    optionDropdownModels =
        FlutterFlowDynamicModels(() => OptionDropdownModel());
  }

  @override
  void dispose() {
    optionDropdownModels.dispose();
  }
}
