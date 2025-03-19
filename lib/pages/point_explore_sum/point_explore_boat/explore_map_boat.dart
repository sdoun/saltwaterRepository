import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:salt_water_beta_ver1/reusable/common/basicScaffold.dart';

import '../../../app_state.dart';
import '../../../auth/firebase_auth/auth_util.dart';
import '../../../backend/schema/t_b_point_record.dart';
import '../../../custom_code/widgets/naver_map_widget_point_copy.dart' as custom_widgets;
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/nav/serialization_util.dart';
import '../../../reusable/pointExplore/mapSelectButton.dart';

class ExploreMapBoat extends StatefulWidget {
  const ExploreMapBoat({super.key});

  @override
  State<ExploreMapBoat> createState() => _ExploreMapBoatState();
}

class _ExploreMapBoatState extends State<ExploreMapBoat> {

  Future<QuerySnapshot> getPoints(){
    final querySnapshot = FirebaseFirestore.instance.collection('TB_point').where('point_categories', isEqualTo: '낚시배').get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (i, j){
          context.pushNamed('home1');
        },
      //낚시배 조회 페이지 이미지 필요
        child: Basicscaffold(
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
                    context.pushNamed('home1');
                  },
                ),
              ),
            ),
            title: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Text(
                '낚시배 검색하기',
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                child: SizedBox(
                  width: 60,
                  height: 60,
                ),
              ),
            ],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 72,
                      child: Image.asset('assets/images/낚시배.png'),
                    ),
                    Text('낚시배 검색하기',
                      style: FlutterFlowTheme
                          .of(context)
                          .bodyMedium
                          .override(
                        fontFamily:
                        'PretendardSeries',
                        fontSize:
                        16.0,
                        letterSpacing:
                        0.0,
                        fontWeight:
                        FontWeight
                            .w600,
                        useGoogleFonts: GoogleFonts
                            .asMap()
                            .containsKey(
                            'PretendardSeries'),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    FutureBuilder<QuerySnapshot>(
                        future: getPoints(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){

                            final List<TBPointRecord> exploreMapThemeTBPointRecordList = snapshot.data!.docs.map((doc){
                              return TBPointRecord.fromSnapshot(doc);
                            }).toList();
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
                                child:
                                Stack(
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
                                        pointList: exploreMapThemeTBPointRecordList,
                                        currentUser: currentUserReference!,
                                        onClickMarker: (markerDoc) async {
                                          context.pushNamed(
                                            'boat_detailed',
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
                          }
                          else{
                            return Center(
                              child: Text('포인트를 불러오지 못했습니다.'),
                            );
                          }
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
