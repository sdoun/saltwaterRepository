import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bus_fishes_model.dart';
export 'bus_fishes_model.dart';

class BusFishesWidget extends StatefulWidget {
  const BusFishesWidget({super.key});

  @override
  State<BusFishesWidget> createState() => _BusFishesWidgetState();
}

class _BusFishesWidgetState extends State<BusFishesWidget> {
  late BusFishesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusFishesModel());

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
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
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
          height: 477.0,
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
            padding: const EdgeInsetsDirectional.fromSTEB(18.0, 21.0, 18.0, 30.0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    '어종',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '두족류',
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
                          options: const [
                            '전체',
                            '무늬오징어',
                            '갑오징어',
                            '주꾸미',
                            '오징어',
                            '한치',
                            '낙지',
                            '문어',
                          ],
                          selectedCallback: (selectedOptionCallback) async {
                            _model.selectedFish1 =
                                selectedOptionCallback!.toList().cast<String>();
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '농어목, 민어과, 전갱이과',
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 160.0,
                        child: custom_widgets.BusFishTypeChoiceChips(
                          width: double.infinity,
                          height: 160.0,
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
                            '광어',
                            '우럭',
                            '부시리',
                            '삼치',
                            '갈치',
                            '열기',
                            '노래미',
                            '전갱이',
                            '볼락',
                            '농어',
                            '민어',
                            '벤자리'
                          ],
                          selectedCallback: (selectedOptionCallback) async {
                            _model.selectedFish5 =
                                selectedOptionCallback!.toList().cast<String>();
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '가자미목, 쏨뱅이과, 기타',
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
                    SizedBox(
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
                        options: const ['전체', '홍감펭', '임연수'],
                        selectedCallback: (selectedOptionCallback) async {
                          _model.selectedFish2 =
                              selectedOptionCallback!.toList().cast<String>();
                          safeSetState(() {});
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '도미과',
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
                    SizedBox(
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
                        options: const ['전체', '참돔', '감성돔', '뱅에돔'],
                        selectedCallback: (selectedOptionCallback) async {
                          _model.selectedFish3 =
                              selectedOptionCallback!.toList().cast<String>();
                          safeSetState(() {});
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '기타',
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
                    SizedBox(
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
                        options: const [
                          '전체',
                          '참치',
                          '시즌어종',
                          '기타',
                          '베스트조항',
                          '체험낚시',
                          '갯바위',
                          '좌대우터',
                          '해루질',
                          '탐사',
                          '출조안내'
                        ],
                        selectedCallback: (selectedOptionCallback) async {
                          _model.selectedFish4 =
                              selectedOptionCallback!.toList().cast<String>();
                          safeSetState(() {});
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().busFishType = (List<String>? var1,
                                List<String>? var2,
                                List<String>? var3,
                                List<String>? var4,
                                List<String>? var5) {
                      return (var1 ?? []) +
                          (var2 ?? []) +
                          (var3 ?? []) +
                          (var3 ?? []) +
                          (var5 ?? []);
                    }(
                            _model.selectedFish1.toList(),
                            _model.selectedFish2.toList(),
                            _model.selectedFish3.toList(),
                            _model.selectedFish4.toList(),
                            _model.selectedFish5.toList())
                        .toList()
                        .cast<String>();
                    safeSetState(() {});
                    Navigator.pop(
                        context,
                        (List<String>? var1,
                                List<String>? var2,
                                List<String>? var3,
                                List<String>? var4,
                                List<String>? var5) {
                          return (var1 ?? []) +
                              (var2 ?? []) +
                              (var3 ?? []) +
                              (var3 ?? []) +
                              (var5 ?? []);
                        }(
                            _model.selectedFish1.toList(),
                            _model.selectedFish2.toList(),
                            _model.selectedFish3.toList(),
                            _model.selectedFish4.toList(),
                            _model.selectedFish5.toList()));
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
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
              ].divide(const SizedBox(height: 12.0)),
            ),
          ),
        ),
      ),
    );
  }
}
