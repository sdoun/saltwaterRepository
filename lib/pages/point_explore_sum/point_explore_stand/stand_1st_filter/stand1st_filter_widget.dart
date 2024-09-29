import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stand1st_filter_model.dart';
export 'stand1st_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';

class Stand1stFilterWidget extends StatefulWidget {
  const Stand1stFilterWidget({super.key});

  @override
  State<Stand1stFilterWidget> createState() => _Stand1stFilterWidgetState();
}

class _Stand1stFilterWidgetState extends State<Stand1stFilterWidget> {
  late Stand1stFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Stand1stFilterModel());
    _model.checkboxValue1 = _model.checkboxValue1 ??=
        FFAppState()
            .standFacility1
            .contains('좌대');
    _model.checkboxValue2 = _model.checkboxValue2 ??=
        FFAppState()
            .standFacility1
            .contains('해상펜션');
    _model.checkboxValue3 = _model.checkboxValue3 ??=
        FFAppState()
            .standFacility2
            .contains('당일낚시');
    _model.checkboxValue4 = _model.checkboxValue4??=
        FFAppState()
            .standFacility2
            .contains('숙박가능');

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        child: Container(
          width: 351.0,
          height: 380.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18.0, 21.0, 18.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Filtercheckbox(
                      filterText: '좌       대',
                      checkBoxValue: _model.checkboxValue1 ??=
                          FFAppState()
                              .standFacility1
                              .contains('좌대') ==
                              true,
                      onChecked:(newValue) async {
                        safeSetState(() =>
                        _model.checkboxValue1 = newValue!);
                        if (newValue!) {
                          FFAppState().addToStandFacility1('좌대');
                          safeSetState(() {});
                        } else {
                          FFAppState()
                              .removeFromStandFacility1('좌대');
                          safeSetState(() {});
                        }
                      },
                    ),
                    Filtercheckbox(
                      filterText: '해상펜션',
                      checkBoxValue: _model.checkboxValue2 ??=
                          FFAppState()
                              .standFacility1
                              .contains('해상펜션') ==
                              true,
                      onChecked:(newValue) async {
                        safeSetState(() =>
                        _model.checkboxValue2 = newValue!);
                        if (newValue!) {
                          FFAppState().addToStandFacility1('해상펜션');
                          safeSetState(() {});
                        } else {
                          FFAppState()
                              .removeFromStandFacility1('해상펜션');
                          safeSetState(() {});
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Filtercheckbox(
                      filterText: '당일낚시',
                      checkBoxValue: _model.checkboxValue3 ??=
                          FFAppState()
                              .standFacility2
                              .contains('당일낚시'),
                      onChecked:(newValue) async {
                        safeSetState(() =>
                        _model.checkboxValue3 = newValue!);
                        if (newValue!) {
                          FFAppState().addToStandFacility1('당일낚시');
                          safeSetState(() {});
                        } else {
                          FFAppState()
                              .removeFromStandFacility1('당일낚시');
                          safeSetState(() {});
                        }
                      },
                    ),
                    Filtercheckbox(
                      filterText: '숙박가능',
                      checkBoxValue: _model.checkboxValue4 ??=
                          FFAppState()
                              .standFacility2
                              .contains('숙박가능'),
                      onChecked:(newValue) async {
                        safeSetState(() =>
                        _model.checkboxValue4 = newValue!);
                        if (newValue!) {
                          FFAppState().addToStandFacility1('숙박가능');
                          safeSetState(() {});
                        } else {
                          FFAppState()
                              .removeFromStandFacility1('숙박가능');
                          safeSetState(() {});
                        }
                      },
                    ),
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(
                        context,
                        functions.stand1stFilterBottomsheet(
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
              ].divide(const SizedBox(height: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
