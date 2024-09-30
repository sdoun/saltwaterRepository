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
import '/pages/point_explore_sum/point_explore_seawall/seawall_1st_filter/seawall1st_filter_widget.dart';
import '/pages/point_explore_sum/point_explore_seawall/seawall_2nd_filter/seawall2nd_filter_widget.dart';
import '/pages/point_explore_sum/point_explore_seawall/seawall_3rd_filter/seawall3rd_filter_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'explore_map_s_w_model.dart';
export 'explore_map_s_w_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/standFilterButton.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/fishChoiceChips.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/mapSelectButton.dart';


class ExploreMapSWWidget extends StatefulWidget {
  const ExploreMapSWWidget({super.key});

  @override
  State<ExploreMapSWWidget> createState() => _ExploreMapSWWidgetState();
}

class _ExploreMapSWWidgetState extends State<ExploreMapSWWidget> {
  late ExploreMapSWModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreMapSWModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {});
      safeSetState(() {
        _model.choiceChipsValueController?.value = FFAppState().fishes;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<TBPointRecord>>(
      stream: queryTBPointRecord(
        queryBuilder: (tBPointRecord) => tBPointRecord
            .whereIn('point_name',
                _model.sWPointList != '' ? _model.sWPointList : null)
            .where(
              'point_categories',
              isEqualTo: '방파제, 선착장' != '' ? '방파제, 선착장' : null,
              isNull: ('방파제, 선착장' != '' ? '방파제, 선착장' : null) == null,
            ),
      )..listen((snapshot) {
          List<TBPointRecord> exploreMapSWTBPointRecordList = snapshot;
          if (_model.exploreMapSWPreviousSnapshot != null &&
              !const ListEquality(TBPointRecordDocumentEquality()).equals(
                  exploreMapSWTBPointRecordList,
                  _model.exploreMapSWPreviousSnapshot)) {
            () async {
              await _model.columnController?.animateTo(
                _model.columnController!.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );

              safeSetState(() {});
            }();
          }
          _model.exploreMapSWPreviousSnapshot = snapshot;
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
        List<TBPointRecord> exploreMapSWTBPointRecordList = snapshot.data!;

        return GestureDetector(
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
                      context.safePop();
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
                      controller: _model.columnController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
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
                                      controller: _model.choiceChipsValueController ??=
                                          FormFieldController<List<String>>(
                                            FFAppState().fishes,
                                          ),
                                      onChanged: (val) => safeSetState(
                                              () => _model.choiceChipsValues = val),
                                      chipValues: _model.choiceChipsValues,
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(-1.0, 0.0),
                                      child:
                                      Padding(
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
                                                      color: FlutterFlowTheme.of(
                                                          context)
                                                          .primary,
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
                                                          '방파제, 선착장',
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
                                                            const Seawall1stFilterWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ).then((value) => safeSetState(() =>
                                                _model.sW1stFilter = value));

                                                safeSetState(() {});
                                              },
                                              filterValue: _model.sW1stFilter,
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
                                                            const Seawall2ndFilterWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ).then((value) => safeSetState(() =>
                                                _model.sW2ndFilter = value));

                                                safeSetState(() {});
                                              },
                                              filterValue: _model.sW2ndFilter,
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
                                                            const Seawall3rdFilterWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ).then((value) => safeSetState(() =>
                                                _model.sW3rdFilter = value));

                                                safeSetState(() {});
                                              },
                                              filterValue: _model.sW3rdFilter,
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
                                          _model.sWPointList =
                                          await actions.sWFilterSumString(
                                            context,
                                            _model.sW1stFilter?.toList(),
                                            _model.sW2ndFilter?.toList(),
                                            _model.sW3rdFilter?.toList(),
                                            _model.choiceChipsValues?.toList(),
                                          );
                                          _model.filterValue =
                                              exploreMapSWTBPointRecordList
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
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child:
                                        custom_widgets.NaverMapWidgetPointCopy(
                                      width: double.infinity,
                                      height: double.infinity,
                                      mapType: FFAppState().mapTypeString,
                                      pointList: exploreMapSWTBPointRecordList,
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
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: wrapWithModel(
                          model: _model.customNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: const CustomNavbarWidget(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
