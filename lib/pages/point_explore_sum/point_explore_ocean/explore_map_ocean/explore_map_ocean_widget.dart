import '../../../../reusable/common/basicScaffold.dart';
import '../ocean_3rd_filter/ocean3rd_filter_widget.dart';
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
import '/pages/point_explore_sum/point_explore_ocean/ocean_1st_filter/ocean1st_filter_widget.dart';
import '/pages/point_explore_sum/point_explore_ocean/ocean_2nd_filter/ocean2nd_filter_widget.dart';
import '/pages/point_explore_sum/point_explore_seawall/seawall_3rd_filter/seawall3rd_filter_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'explore_map_ocean_model.dart';
export 'explore_map_ocean_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/standFilterButton.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/fishChoiceChips.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/mapSelectButton.dart';

class ExploreMapOceanWidget extends StatefulWidget {
  const ExploreMapOceanWidget({super.key});

  @override
  State<ExploreMapOceanWidget> createState() => _ExploreMapOceanWidgetState();
}

class _ExploreMapOceanWidgetState extends State<ExploreMapOceanWidget> {
  late ExploreMapOceanModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreMapOceanModel());

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
        _model.ocean1stFilter = null;
        _model.ocean2ndFilter = null;
        _model.oceean3rdFilter = null;
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
      _model.pointList =
          await actions.pointListFromFilter(
        _model.ocean1stFilter?.toList(),
        _model.ocean2ndFilter?.toList(),
        _model.oceean3rdFilter?.toList(),
            FFAppState().fishes.toList(),
        'TB_point',
      );
      if(_model.pointList == null || _model.pointList!.isEmpty){
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
          child: StreamBuilder<List<TBPointRecord>>(
            stream: queryTBPointRecord(
              queryBuilder: (tBPointRecord) => tBPointRecord,
            ).map((snapshot) {
              return snapshot.where((record) {
                bool matchesName = _model.pointList == [] ||
                    _model.pointList!.contains(record.pointName);
                bool matchesCategory = '해변, 갯바위' == '' ||
                    record.pointCategories == '해변, 갯바위';
                return matchesName && matchesCategory;
              }).toList();
            })..listen((snapshot) {
              List<TBPointRecord> exploreMapSWTBPointRecordList = snapshot;
              if (_model.exploreMapOceanPreviousSnapshot != null &&
                  !const ListEquality(TBPointRecordDocumentEquality()).equals(
                      exploreMapSWTBPointRecordList,
                      _model.exploreMapOceanPreviousSnapshot)) {
                () async {
                  await _model.columnController?.animateTo(
                    _model.columnController!.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.ease,
                  );

                  safeSetState(() {});
                }();
              }
              _model.exploreMapOceanPreviousSnapshot = snapshot;
            }),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Scaffold(
                  backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                  body: Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  ),
                );
              }
              List<TBPointRecord> exploreMapOceanTBPointRecordList = snapshot.data!;

              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Basicscaffold(
                  key: scaffoldKey,
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
                    actions: const [
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
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                          child: SingleChildScrollView(
                            //controller: _model.columnController,
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                Fishchoicechips(
                                controller: _model.choiceChipsValueController
                                ??=
                                FormFieldController<List<String>>(
                                    FFAppState().fishes,
                              ),
                              chipValues: _model.choiceChipsValues,
                              onChanged: (val) {
                                safeSetState(
                                        () =>
                                    _model.choiceChipsValues = val);
                                filterPoint();
                                setState(() {
                                });
                              },
                            ),

                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: _model.rowController,
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
                                            backgroundColor:
                                            const Color(0x24000000),
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding: MediaQuery
                                                        .viewInsetsOf(
                                                        context),
                                                    child:
                                                    const PointCategoryWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) =>
                                              safeSetState(() {}));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: Container(
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8.0),
                                              border: Border.all(
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  width: 2
                                              ),
                                            ),
                                            alignment: const AlignmentDirectional(
                                                0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8.0, 0.0, 4.0, 0.0),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    '해변, 갯바위',
                                                    style:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'PretendardSeries',
                                                      color: FlutterFlowTheme.of(
                                                          context)
                                                          .primaryText,
                                                      fontSize:
                                                      12.0,
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
                                                  Align(
                                                    alignment:
                                                    const AlignmentDirectional(
                                                        1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          3.0,
                                                          0.0,
                                                          0.0,
                                                          0.0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_outlined,
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .primaryText,
                                                        size: 18.0,
                                                      ),
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
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor:
                                            Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding: MediaQuery
                                                        .viewInsetsOf(
                                                        context),
                                                    child:
                                                    const Ocean1stFilterWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(
                                                  () => _model.ocean1stFilter =
                                                  value));
                                          filterPoint();

                                          safeSetState(() {});
                                        },
                                        filterValue: _model.ocean1stFilter,
                                      ),
                                      Standfilterbutton(
                                        iniitalText: '편의시설',
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor:
                                            Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding: MediaQuery
                                                        .viewInsetsOf(
                                                        context),
                                                    child:
                                                    const Ocean2ndFilterWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(
                                                  () => _model.ocean2ndFilter =
                                                  value));
                                          filterPoint();

                                          safeSetState(() {});
                                        },
                                        filterValue: _model.ocean2ndFilter,
                                      ),
                                      Standfilterbutton(
                                        iniitalText: '편의사항',
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor:
                                            Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return WebViewAware(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding: MediaQuery
                                                        .viewInsetsOf(
                                                        context),
                                                    child:
                                                    const Ocean3rdFilterWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(
                                                  () => _model.oceean3rdFilter =
                                                  value));
                                          filterPoint();

                                          safeSetState(() {});
                                        },
                                        filterValue: _model.oceean3rdFilter,
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
                                            _model.filterValue =
                                                exploreMapOceanTBPointRecordList
                                                    .toList()
                                                    .cast<TBPointRecord>();
                                            safeSetState(() {});

                                            safeSetState(() {});
                                          },
                                          text: '선택완료',
                                          options: FFButtonOptions(
                                            width:
                                            MediaQuery.sizeOf(context).width *
                                                0.8,
                                            height: 40.0,
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
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
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            ClipRRect(
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
                                        pointList:
                                        exploreMapOceanTBPointRecordList,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
