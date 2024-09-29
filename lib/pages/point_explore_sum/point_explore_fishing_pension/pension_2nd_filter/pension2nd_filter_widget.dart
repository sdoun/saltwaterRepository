import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pension2nd_filter_model.dart';
export 'pension2nd_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';

class Pension2ndFilterWidget extends StatefulWidget {
  const Pension2ndFilterWidget({super.key});

  @override
  State<Pension2ndFilterWidget> createState() => _Pension2ndFilterWidgetState();
}

class _Pension2ndFilterWidgetState extends State<Pension2ndFilterWidget> {
  late Pension2ndFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Pension2ndFilterModel());
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
    return Material(
      color: Colors.transparent,
      elevation: 3.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Container(
        width: 351.0,
        height: 380.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(18.0, 21.0, 18.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '인근편의시설',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily:'PretendardSeries',
                  fontSize: 19.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w700,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      'PretendardSeries'),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Filtercheckbox(
                      filterText: '주변낚시터',
                      checkBoxValue: _model.checkboxValue3,
                      onChecked: (newValue) async {
                        safeSetState(() =>
                        _model.checkboxValue3 = newValue!);
                      },
                    ),
                    Filtercheckbox(
                      filterText: '낚시방',
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
                        functions.pension2ndFilterBottomsheet(
                            _model.checkboxValue3!,
                            _model.checkboxValue1!,
                            _model.checkboxValue2!,
                            _model.checkboxValue4!));
                  },
                  child: Container(
                    width: 100.0,
                    height: 43.0,
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
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).primaryBackground,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
