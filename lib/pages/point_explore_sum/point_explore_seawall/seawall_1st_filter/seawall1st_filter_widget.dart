import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seawall1st_filter_model.dart';
export 'seawall1st_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/filterBackground.dart';

class Seawall1stFilterWidget extends StatefulWidget {
  const Seawall1stFilterWidget({super.key, this.filterAction});

  final filterAction;

  @override
  State<Seawall1stFilterWidget> createState() => _Seawall1stFilterWidgetState();
}

class _Seawall1stFilterWidgetState extends State<Seawall1stFilterWidget> {
  late Seawall1stFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Seawall1stFilterModel());
    _model.checkboxValue1 = false;
    _model.checkboxValue2 = false;

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Filterbackground(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '시설구분',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              fontSize: 19.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w700,
              useGoogleFonts: GoogleFonts.asMap().containsKey(
                  FlutterFlowTheme.of(context).bodyMediumFamily),
            ),
          ),
          Divider(
            thickness: 1.0,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Filtercheckbox(
                  filterText: '외항 석축',
                  checkBoxValue: _model.checkboxValue1,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue1 = newValue!);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Filtercheckbox(
                  filterText: '외항 테트라포드',
                  checkBoxValue: _model.checkboxValue2,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue2 = newValue!);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.sWType = await actions.seawallType(
                  _model.checkboxValue2!,
                  _model.checkboxValue1   !,
                );
                Navigator.pop(context, _model.sWType);
                widget.filterAction;
                safeSetState(() {});
              },
              child: Container(
                width: 100.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    '선택완료',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily:
                      'PretendardSeries',
                      color: FlutterFlowTheme.of(context)
                          .primaryBackground,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          'PretendardSeries'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
