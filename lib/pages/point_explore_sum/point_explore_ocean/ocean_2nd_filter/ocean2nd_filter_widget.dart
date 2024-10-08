import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ocean2nd_filter_model.dart';
export 'ocean2nd_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/filterBackground.dart';

class Ocean2ndFilterWidget extends StatefulWidget {
  const Ocean2ndFilterWidget({super.key});

  @override
  State<Ocean2ndFilterWidget> createState() => _Ocean2ndFilterWidgetState();
}

class _Ocean2ndFilterWidgetState extends State<Ocean2ndFilterWidget> {
  late Ocean2ndFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Ocean2ndFilterModel());
    _model.checkboxValue1 = false;
    _model.checkboxValue2 = false;
    _model.checkboxValue3 = false;
    _model.checkboxValue4 = false;
    _model.checkboxValue5 = false;

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
        children: [
          Text(
            '인근편의시설',
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
                  filterText: '식   당',
                  checkBoxValue: _model.checkboxValue1,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue1 = newValue!);
                  },
                ),
                Filtercheckbox(
                  filterText: '매   점',
                  checkBoxValue: _model.checkboxValue2,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue2 = newValue!);
                  },
                ),
                Filtercheckbox(
                  filterText: '낚시방',
                  checkBoxValue: _model.checkboxValue3,
                  onChecked: (newValue) async {
                    safeSetState(() =>
                    _model.checkboxValue3 = newValue!);
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Filtercheckbox(
                filterText: '숙   소',
                checkBoxValue: _model.checkboxValue4,
                onChecked: (newValue) async {
                  safeSetState(() =>
                  _model.checkboxValue4 = newValue!);
                },
              ),
              Filtercheckbox(
                filterText: '화장실',
                checkBoxValue: _model.checkboxValue5,
                onChecked: (newValue) async {
                  safeSetState(() =>
                  _model.checkboxValue5 = newValue!);
                },
              ),
            ],
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
                    functions.ocean2ndFilterBottomsheet(
                        _model.checkboxValue5!,
                        _model.checkboxValue1!,
                        _model.checkboxValue2!,
                        _model.checkboxValue4!,
                        _model.checkboxValue3!));
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
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }
}
