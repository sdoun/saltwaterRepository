import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'stand3rd_filter_model.dart';
export 'stand3rd_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';

class Stand3rdFilterWidget extends StatefulWidget {
  const Stand3rdFilterWidget({super.key});

  @override
  State<Stand3rdFilterWidget> createState() => _Stand3rdFilterWidgetState();
}

class _Stand3rdFilterWidgetState extends State<Stand3rdFilterWidget> {
  late Stand3rdFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Stand3rdFilterModel());
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
    return Material(
      color: Colors.transparent,
      elevation: 3.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Container(
        width: 351.0,
        height: 380.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '편의사항',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Filtercheckbox(
                      filterText: '장비대여',
                      checkBoxValue: _model.checkboxValue1,
                      onChecked: (newValue) async {
                        safeSetState(() =>
                        _model.checkboxValue1 = newValue!);
                      },
                  ),
                  Filtercheckbox(
                    filterText: '장비판매',
                    checkBoxValue: _model.checkboxValue2,
                    onChecked: (newValue) async {
                      safeSetState(() =>
                      _model.checkboxValue2 = newValue!);
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
                      functions.park3rdFilterBottomsheet(
                          _model.checkboxValue1!, _model.checkboxValue2!));
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
    );
  }
}
