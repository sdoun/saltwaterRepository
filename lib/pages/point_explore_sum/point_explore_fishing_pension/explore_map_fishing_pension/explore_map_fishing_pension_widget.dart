import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/point_explore_sum/map_type_select/map_type_select_widget.dart';
import '/pages/point_explore_sum/point_category/point_category_widget.dart';
import '/pages/point_explore_sum/point_explore_fishing_pension/pension_1st_filter/pension1st_filter_widget.dart';
import '/pages/point_explore_sum/point_explore_fishing_pension/pension_2nd_filter/pension2nd_filter_widget.dart';
import '/pages/point_explore_sum/point_explore_fishing_pension/pension_3rd_filter/pension3rd_filter_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'explore_map_fishing_pension_model.dart';
export 'explore_map_fishing_pension_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/standFilterButton.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/fishChoiceChips.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/mapSelectButton.dart';


class ExploreMapFishingPensionWidget extends StatefulWidget {
  const ExploreMapFishingPensionWidget({super.key});

  @override
  State<ExploreMapFishingPensionWidget> createState() =>
      _ExploreMapFishingPensionWidgetState();
}

class _ExploreMapFishingPensionWidgetState
    extends State<ExploreMapFishingPensionWidget> {
  late ExploreMapFishingPensionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreMapFishingPensionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {
        _model.choiceChipsValueController?.value = FFAppState().fishes;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    filterPoint();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void filterClear(){
    setState((){
      _model.pension1stFilter = null;
      _model.pension2ndFilter = null;
      _model.pension3rdFilter = null;
      FFAppState().fishes.clear();
      _model.setFilterValueExit();
    }
    );
    filterPoint();
  }

  void pop(bool filterExit){
    if(filterExit){
      filterClear();
    }
    else{
      context.pushNamed('home1');
    }
  }

  void filterPoint() async{
    _model.pensionPointList =
    await actions.sWFilterSumString(
      context,
      _model.pension1stFilter?.toList(),
      _model.pension2ndFilter?.toList(),
      _model.pension3rdFilter?.toList(),
      _model.choiceChipsValues?.toList(),
    );
    if(_model.pensionPointList == null || _model.pensionPointList!.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('조건에 일치하는 포인트가 없습니다.')),
      );
    }
    safeSetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didpop, result){
          _model.setFilterValueExit();
          pop(_model.filterValueExit);
        },
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: const AlignmentDirectional(-1.0, -3.7),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () async {
                  _model.setFilterValueExit();
                  pop(_model.filterValueExit);
                },
              ),
            ),
          ),
          title: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Text(
              '포인트 검색하기',
              style: FlutterFlowTheme
                  .of(context)
                  .bodyMedium
                  .override(
                fontFamily:
                'PretendardSeries',
                color: FlutterFlowTheme.of(
                    context)
                    .primaryText,
                fontSize:
                19.0,
                letterSpacing:
                0.0,
                fontWeight:
                FontWeight
                    .w700,
                useGoogleFonts: GoogleFonts
                    .asMap()
                    .containsKey(
                    'PretendardSeries'),
              ),
            ),
          ),
          actions: const[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              child: SizedBox(
                width: 60,
                height: 60,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Fishchoicechips(
                                onChanged: (val){safeSetState(
                                        () => _model.choiceChipsValues = val);
                                  filterPoint();
                                  setState(() {
                                  });
                                },
                                controller: _model.choiceChipsValueController ??=
                                    FormFieldController<List<String>>(
                                      FFAppState().fishes,
                                    ),
                                chipValues: _model.choiceChipsValues,
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor: const Color(0x24000000),
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return WebViewAware(
                                                  child: GestureDetector(
                                                    onTap: () =>
                                                        FocusScope.of(context)
                                                            .unfocus(),
                                                    child: Padding(
                                                      padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                      child:
                                                      const PointCategoryWidget(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                    (value) => safeSetState(() {}));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            child: Container(
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: FlutterFlowTheme.of(context)
                                                        .primary, width: 2
                                                ),
                                              ),
                                              alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(8.0, 0.0, 4.0, 0.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '낚시펜션, 민박',
                                                      style: FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'PretendardSeries',
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryText,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        useGoogleFonts:
                                                        GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            'PretendardSeries'),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_outlined,
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryText,
                                                        size: 18.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Standfilterbutton(
                                          iniitalText: '시설구분',
                                          onTap: () async{
                                            await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                        child:
                                                        const Pension1stFilterWidget(),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ).then((value) => safeSetState(() =>
                                            _model.pension1stFilter = value));
                                            filterPoint();

                                            safeSetState(() {});
                                          },
                                          filterValue: _model.pension1stFilter,
                                        ),
                                        Standfilterbutton(
                                          iniitalText: '편의시설',
                                          onTap: () async{
                                            await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                        child:
                                                        const Pension2ndFilterWidget(),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ).then((value) => safeSetState(() =>
                                            _model.pension2ndFilter = value));
                                            filterPoint();

                                            safeSetState(() {});
                                          },
                                          filterValue: _model.pension2ndFilter,
                                        ),
                                        Standfilterbutton(
                                          iniitalText: '편의사항',
                                          onTap: () async{
                                            await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                        child:
                                                        const Pension3rdFilterWidget(),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ).then((value) => safeSetState(() =>
                                            _model.pension3rdFilter = value));
                                            filterPoint();

                                            safeSetState(() {});
                                          },
                                          filterValue: _model.pension3rdFilter,
                                        ),
                                      ].divide(const SizedBox(width: 4.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 24.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    filterPoint();

                                    safeSetState(() {});
                                  },
                                  text: '선택완료',
                                  options: FFButtonOptions(
                                    width:
                                    MediaQuery.sizeOf(context).width * 0.8,
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'PretendardSeries',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('PretendardSeries'),
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
                      StreamBuilder<List<TBPointRecord>>(
                        stream: queryTBPointRecord(
                          queryBuilder: (tBPointRecord) => tBPointRecord
                        ).map((snapshot){
                          return snapshot.where((record) {
                            bool matchesName = _model.pensionPointList == [] ||
                                _model.pensionPointList!.contains(record.pointName);
                            bool matchesCategory = '낚시펜션, 민박' == '' ||
                                record.pointCategories == '낚시펜션, 민박';
                            return matchesName && matchesCategory;
                          }).toList();
                        })..listen((snapshot) {
                        }),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<TBPointRecord> containerTBPointRecordList =
                          snapshot.data!;

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 461.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child:
                                    custom_widgets.NaverMapWidgetPointCopy(
                                      width: double.infinity,
                                      height: double.infinity,
                                      mapType: FFAppState().mapTypeString,
                                      pointList: containerTBPointRecordList,
                                      currentUser: currentUserReference!,
                                      onClickMarker: (markerDoc) async {
                                        context.pushNamed(
                                          'point_detailed',
                                          queryParameters: {
                                            'pointRefSW': serializeParam(
                                              markerDoc.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                    ),
                                  ),
                                  Mapselectbutton(
                                    onSelected: () async{
                                      Navigator.pop(context);
                                      safeSetState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 640.0, 0.0, 0.0),
                  child: wrapWithModel(
                    model: _model.customNavbarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const CustomNavbarWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
