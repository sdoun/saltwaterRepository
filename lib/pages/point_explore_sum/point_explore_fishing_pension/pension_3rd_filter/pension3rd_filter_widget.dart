import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pension3rd_filter_model.dart';
export 'pension3rd_filter_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/filterCheckBox.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/filterBackground.dart';

class Pension3rdFilterWidget extends StatefulWidget {
  const Pension3rdFilterWidget({super.key});

  @override
  State<Pension3rdFilterWidget> createState() => _Pension3rdFilterWidgetState();
}

class _Pension3rdFilterWidgetState extends State<Pension3rdFilterWidget> {
  late Pension3rdFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Pension3rdFilterModel());
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '편의사항',
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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Filtercheckbox(
                filterText: '식사제공',
                checkBoxValue: _model.checkboxValue1,
                onChecked: (newValue) async {
                  safeSetState(() =>
                  _model.checkboxValue1 = newValue!);
                },
              ),
              Filtercheckbox(
                filterText: '낚시대대여',
                checkBoxValue: _model.checkboxValue2,
                onChecked: (newValue) async {
                  safeSetState(() =>
                  _model.checkboxValue2 = newValue!);
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Filtercheckbox(
                filterText: '낚시배&좌대 이용가능',
                checkBoxValue: _model.checkboxValue3,
                onChecked: (newValue) async {
                  safeSetState(() =>
                  _model.checkboxValue3 = newValue!);
                },
              ),
              Filtercheckbox(
                filterText: '물놀이가능',
                checkBoxValue: _model.checkboxValue4,
                onChecked: (newValue) async {
                  safeSetState(() =>
                  _model.checkboxValue4 = newValue!);
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
                    functions.pension3rdFilterBottomsheet(
                        _model.checkboxValue1!,
                        _model.checkboxValue3!,
                        _model.checkboxValue2!,
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
                      FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      fontSize: 17.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
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
