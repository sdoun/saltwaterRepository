import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bus_area_model.dart';
export 'bus_area_model.dart';

class BusAreaWidget extends StatefulWidget {
  const BusAreaWidget({super.key});

  @override
  State<BusAreaWidget> createState() => _BusAreaWidgetState();
}

class _BusAreaWidgetState extends State<BusAreaWidget>
    with TickerProviderStateMixin {
  late BusAreaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusAreaModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
      height: 343.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Align(
        alignment: const AlignmentDirectional(-1.0, 0.0),
        child: Column(
          children: [
            Align(
              alignment: const Alignment(0.0, 0),
              child: TabBar(
                labelColor: FlutterFlowTheme.of(context).primaryText,
                unselectedLabelColor:
                    FlutterFlowTheme.of(context).secondaryText,
                labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleMediumFamily,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleMediumFamily),
                    ),
                unselectedLabelStyle: const TextStyle(),
                indicatorColor: FlutterFlowTheme.of(context).primaryText,
                indicatorWeight: 3.0,
                padding: const EdgeInsets.all(4.0),
                tabs: const [
                  Tab(
                    text: '지역별',
                  ),
                  Tab(
                    text: '지역 인근별',
                  ),
                ],
                controller: _model.tabBarController,
                onTap: (i) async {
                  [() async {}, () async {}][i]();
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _model.tabBarController,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '인천',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40.0,
                                child: custom_widgets.BusFishTypeChoiceChips(
                                  width: double.infinity,
                                  height: 40.0,
                                  selectedTextColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  unselectedTextColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  selectedBorderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBorderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  options: const ['전체', '인천 남구', '인천 서구', '인천 중구'],
                                  selectedCallback:
                                      (selectedOptionCallback) async {
                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '경기',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40.0,
                                child: custom_widgets.BusFishTypeChoiceChips(
                                  width: double.infinity,
                                  height: 40.0,
                                  selectedTextColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  unselectedTextColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  selectedBorderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBorderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  options: const [
                                    '전체',
                                    '경기 시흥',
                                    '경기 안산',
                                    '경기 평택',
                                    '경기 확성'
                                  ],
                                  selectedCallback:
                                      (selectedOptionCallback) async {
                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '호남',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40.0,
                                child: custom_widgets.BusFishTypeChoiceChips(
                                  width: double.infinity,
                                  height: 40.0,
                                  selectedTextColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  unselectedTextColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  selectedBorderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBorderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  options: const ['전체', '호남 당진', '호남 태안'],
                                  selectedCallback:
                                      (selectedOptionCallback) async {
                                    safeSetState(() {});
                                  },
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: '적용',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(height: 8.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '서해',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40.0,
                                child: custom_widgets.BusFishTypeChoiceChips(
                                  width: double.infinity,
                                  height: 40.0,
                                  selectedTextColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  unselectedTextColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  selectedBorderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBorderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  options: const ['전체', '인천인근', '태안인근', '평택인근'],
                                  selectedCallback:
                                      (selectedOptionCallback) async {
                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  '남해',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 17.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40.0,
                                child: custom_widgets.BusFishTypeChoiceChips(
                                  width: double.infinity,
                                  height: 40.0,
                                  selectedTextColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  unselectedTextColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  selectedBorderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedBorderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  options: const ['전체', '여수인근', '통영인근'],
                                  selectedCallback:
                                      (selectedOptionCallback) async {
                                    safeSetState(() {});
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              FFAppState().busArea =
                                  _model.area.toList().cast<String>();
                              safeSetState(() {});
                              Navigator.pop(context);
                            },
                            text: '적용',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ].divide(const SizedBox(height: 8.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
