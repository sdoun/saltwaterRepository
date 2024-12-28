import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/backend/backend.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_model.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../../app_state.dart';
import '../../backend/schema/t_b_point_record.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;

class HomeSearchresult extends StatefulWidget {
  const HomeSearchresult({super.key, required this.searchText});
  final String searchText;

  @override
  State<HomeSearchresult> createState() => _HomeSearchresultState();
}

class _HomeSearchresultState extends State<HomeSearchresult> {

  TextEditingController textController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();
  String? Function(BuildContext, String?)? textControllerValidator;
  List<TBPointRecord> pointList = [];
  List<TBPointRecord> pointAll = [];
  bool isLoading = false;
  
  void getAllPoints() async{
    setState(() {
      isLoading = true;
    });
    List<TBPointRecord>? pointsQuery = await queryTBPointRecordOnce(
        queryBuilder: (tbPointRecord){
          return tbPointRecord.orderBy('point_name');
        }
    );
    if(pointsQuery.isNotEmpty){
      pointAll = pointsQuery;
    }
    pointList = actions.pointSearch(widget.searchText, pointAll);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    print(widget.searchText);
    getAllPoints();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: const AlignmentDirectional(-1.0, -3.7),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  24.0, 0.0, 0.0, 0.0),
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
                  context.pop();
                },
              ),
            ),
          ),
          title: Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0, 0.0, 0.0, 0.0),
              child: Text(
                '검색',
                style: FlutterFlowTheme
                    .of(context)
                    .bodyMedium
                    .override(
                  fontFamily: 'PretendardSeries',
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w800,
                  useGoogleFonts: GoogleFonts.asMap()
                      .containsKey('PretendardSeries'),
                ),
              ),
            ),
          ),
          actions: const [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
                size: 30.0,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
            child: Stack(
              children: [
                Container(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(20),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () async {
                                safeSetState(() {});
                                context.pushNamed('homeSearchPage');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border(
                                        top: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                        left: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                        right: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                        bottom: BorderSide(color: FlutterFlowTheme.of(context).primary)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 8, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          safeSetState(() {});
                                          context.pushNamed('homeSearchPage');
                                        },
                                        child: Text(
                                          widget.searchText,
                                          style: FlutterFlowTheme.of(context).bodyMedium
                                              .override(
                                            fontFamily: 'PretendardSeries',
                                            fontSize: 14.0,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            letterSpacing:
                                            0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          safeSetState(() {});
                                          context.pushNamed('homeSearchPage', queryParameters: {'searchText':widget.searchText});
                                        },
                                        child: Container(
                                          width: 32.0,
                                          height: 32.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/검색.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if(!isLoading && pointList.isNotEmpty)
                            Builder(
                                builder: (context){
                                  var points = pointList;
                                  if(points.isNotEmpty) {
                                    return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: points.map((point) {
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.all(8),
                                        child: InkWell(
                                          onTap: () {
                                            context.pushNamed('point_detailed', queryParameters: {
                                              'pointRefSW': serializeParam(point.reference, ParamType.DocumentReference)
                                            }.withoutNulls);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 36,
                                                height: 36,
                                                child: functions.pointTypeImage(point)
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                point.pointName,
                                                style: FlutterFlowTheme.of(context)
                                                    .headlineSmall
                                                    .override(
                                                  fontFamily:
                                                  'PretendardSeries',
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      'PretendardSeries'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                  }
                                  else{
                                    return Center(
                                        child: Text(
                                            '검색결과 없음',
                                          style: FlutterFlowTheme
                                              .of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color:
                                            FlutterFlowTheme
                                                .of(
                                                context)
                                                .primaryText,
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FontWeight.w700,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        )
                                    );
                                  }
                                }
                            ),
                          if(isLoading || pointList.isEmpty)
                            Center(
                              child: Text(
                                  '검색결과 없음',
                                style: FlutterFlowTheme
                                    .of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color:
                                  FlutterFlowTheme
                                      .of(
                                      context)
                                      .primaryText,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w700,
                                  useGoogleFonts: GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
