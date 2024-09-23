import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bus_extar_filter_model.dart';
export 'bus_extar_filter_model.dart';

class BusExtarFilterWidget extends StatefulWidget {
  const BusExtarFilterWidget({super.key});

  @override
  State<BusExtarFilterWidget> createState() => _BusExtarFilterWidgetState();
}

class _BusExtarFilterWidgetState extends State<BusExtarFilterWidget> {
  late BusExtarFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusExtarFilterModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 377.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Text(
                  '필터링',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 21.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ),
              Divider(
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      '결제방법',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: custom_widgets.BusFishTypeChoiceChips(
                        width: double.infinity,
                        height: 40.0,
                        selectedTextColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        unselectedTextColor:
                            FlutterFlowTheme.of(context).primaryText,
                        selectedBackgroundColor:
                            FlutterFlowTheme.of(context).primary,
                        unselectedBackgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        selectedBorderColor:
                            FlutterFlowTheme.of(context).primary,
                        unselectedBorderColor:
                            FlutterFlowTheme.of(context).primaryText,
                        options: const ['전체', '무통장', '가상계좌', '카드결제'],
                        selectedCallback: (selectedOptionCallback) async {
                          _model.extraFilter =
                              selectedOptionCallback!.toList().cast<String>();
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      '공략방법',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200.0,
                      child: custom_widgets.BusFishTypeChoiceChips(
                        width: double.infinity,
                        height: 200.0,
                        selectedTextColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        unselectedTextColor:
                            FlutterFlowTheme.of(context).primaryText,
                        selectedBackgroundColor:
                            FlutterFlowTheme.of(context).primary,
                        unselectedBackgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        selectedBorderColor:
                            FlutterFlowTheme.of(context).primary,
                        unselectedBorderColor:
                            FlutterFlowTheme.of(context).primaryText,
                        options: const [
                          '전체',
                          '똥침',
                          '침선',
                          '어초',
                          '루어',
                          '다운샷',
                          '타이라바',
                          '흘림 찌낚시',
                          '생미끼',
                          '생미끼 외수질',
                          '캐스팅',
                          '지깅',
                          '선상',
                          '갯바위'
                        ],
                        selectedCallback: (selectedOptionCallback) async {
                          _model.extraFilter =
                              selectedOptionCallback!.toList().cast<String>();
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Text(
                        '이용시간',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 120.0,
                        child: custom_widgets.BusFishTypeChoiceChips(
                          width: double.infinity,
                          height: 120.0,
                          selectedTextColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          unselectedTextColor:
                              FlutterFlowTheme.of(context).primaryText,
                          selectedBackgroundColor:
                              FlutterFlowTheme.of(context).primary,
                          unselectedBackgroundColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          selectedBorderColor:
                              FlutterFlowTheme.of(context).primary,
                          unselectedBorderColor:
                              FlutterFlowTheme.of(context).primaryText,
                          options: const ['전체', '3시간이하', '3~6시간', '6~9시간', '9시간이상'],
                          selectedCallback: (selectedOptionCallback) async {
                            _model.tiemOfUse =
                                selectedOptionCallback!.toList().cast<String>();
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      FFAppState().busExtraFilter =
                          _model.extraFilter.toList().cast<String>();
                      FFAppState().busTime =
                          _model.tiemOfUse.toList().cast<String>();
                      safeSetState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 100.0,
                      height: 43.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          '선택완료',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
