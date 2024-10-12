import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'park1st_filter_model.dart';
export 'park1st_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/filterBackground.dart';

class Park1stFilterWidget extends StatefulWidget {
  const Park1stFilterWidget({super.key});

  @override
  State<Park1stFilterWidget> createState() => _Park1stFilterWidgetState();
}

class _Park1stFilterWidgetState extends State<Park1stFilterWidget> {
  late Park1stFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Park1stFilterModel());
    _model.checkboxValue1 = false;
    _model.checkboxValue2 = false;
    _model.checkboxValue3 = false;
    _model.checkboxValue4 = false;

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
              fontFamily:
              FlutterFlowTheme.of(context).bodyMediumFamily,
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
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Filtercheckbox(
                  filterText: '유료시설',
                  checkBoxValue: _model.checkboxValue1,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue1 = newValue!);
                  },
                ),
                Filtercheckbox(
                  filterText: '무료시설',
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
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Filtercheckbox(
                  filterText: '자  연  식',
                  checkBoxValue: _model.checkboxValue3,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue3 = newValue!);
                  },
                ),
                Filtercheckbox(
                  filterText: '입  어  식',
                  checkBoxValue: _model.checkboxValue4,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue4 = newValue!);
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
                Navigator.pop(
                    context,
                    functions.park1stFilterBottomsheet(
                        _model.checkboxValue1!,
                        _model.checkboxValue2!,
                        _model.checkboxValue3!,
                        _model.checkboxValue4!));
              },
              child: Container(
                width: 100.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    '선택완료',
                    style: FlutterFlowTheme.of(context)
                        .bodyMedium
                        .override(
                      fontFamily: 'PretendartSeries',
                      fontSize: 15.0,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: GoogleFonts
                          .asMap()
                          .containsKey(
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
