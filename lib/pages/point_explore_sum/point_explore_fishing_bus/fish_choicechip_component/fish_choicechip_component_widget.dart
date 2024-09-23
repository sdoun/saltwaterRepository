import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'fish_choicechip_component_model.dart';
export 'fish_choicechip_component_model.dart';

class FishChoicechipComponentWidget extends StatefulWidget {
  const FishChoicechipComponentWidget({super.key});

  @override
  State<FishChoicechipComponentWidget> createState() =>
      _FishChoicechipComponentWidgetState();
}

class _FishChoicechipComponentWidgetState
    extends State<FishChoicechipComponentWidget> {
  late FishChoicechipComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FishChoicechipComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120.0,
      child: custom_widgets.BusFishTypeChoiceChips(
        width: double.infinity,
        height: 120.0,
        selectedTextColor: FlutterFlowTheme.of(context).primaryBackground,
        unselectedTextColor: FlutterFlowTheme.of(context).primaryText,
        selectedBackgroundColor: FlutterFlowTheme.of(context).primary,
        unselectedBackgroundColor:
            FlutterFlowTheme.of(context).primaryBackground,
        selectedBorderColor: FlutterFlowTheme.of(context).primary,
        unselectedBorderColor: FlutterFlowTheme.of(context).primaryText,
        options: const [
          '전체',
          '참치',
          '시즌어종',
          '우럭',
          '기타',
          '베스트조항',
          '체험낚시',
          '갯바위',
          '참돔',
          '좌대우터',
          '해루질',
          '탐사',
          '출조안내'
        ],
        selectedCallback: (selectedOptionCallback) async {
          _model.selectend = selectedOptionCallback!.toList().cast<String>();
          safeSetState(() {});
        },
      ),
    );
  }
}
