import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/backend/backend.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:salt_water_beta_ver1/reusable/common/basicScaffold.dart';

import '../../../flutter_flow/custom_functions.dart' as functions;
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/nav/serialization_util.dart';

class ReviewDetailed extends StatefulWidget {
  const ReviewDetailed({super.key, required this.reviewRef});

  final String reviewRef;

  @override
  State<ReviewDetailed> createState() => _ReviewDetailedState();
}

Future<TBUserReviewPointRecord> getDoc(String path) async{
  final reference = await FirebaseFirestore.instance.doc(path);
  final doc = TBUserReviewPointRecord.getDocumentOnce(reference);
  return doc;
}

class _ReviewDetailedState extends State<ReviewDetailed> {
  //리뷰 상세보기 페이지 개발
  @override
  Widget build(BuildContext context) {
    print('ref: ${widget.reviewRef}');
    
    return Basicscaffold(
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
                context.pop();
              },
            ),
          ),
        ),
        title: Align(
          alignment: const AlignmentDirectional(0.0, -1.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
            child: Text(
              '리뷰',
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
        ),
        actions: const [FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.transparent,
            size: 30.0,
          ),
        ),],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.fromSTEB(24, 20, 24, 20),
          child: FutureBuilder(
            //TODO: 쿼리문제 확인 필요
            future: getDoc(widget.reviewRef),/*
            FirebaseFirestore.instance.collection('TB_point').doc('ChDngAdBZ5TCAiAxphN')
                .collection('TB_userReview_point').doc('AdztVt7lfyK8n3atY74T').get(),
                */

            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('snapshot error: ${snapshot.error}');

                return Center(
                      child: Text('리뷰 정보를 불러오지 못했습니다.\n 인터넷 연결을 확인하거나 다시 접속해주세요.')
                  );
              }

              else if(!snapshot.hasData){
                print('스냅샷 데이터 없음 ${snapshot.connectionState}');
                return Center(child: Text('리뷰를 블러오지 못했습니다.'));
              }
              else{
                final reviewRecord = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 40,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(
                            builder: (context){
                              final images = reviewRecord.reviewImages;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(images.length, (index){
                                    final imageItem = images[index];
                                    return InkWell(
                                      onTap: ()async {
                                        context.pushNamed(
                                          'photoViewPage',
                                          queryParameters: {
                                            'imageList': serializeParam(
                                              images,
                                              ParamType.String,
                                              isList: true,
                                            ),
                                            'currentIndex' : serializeParam(index, ParamType.int, isList: false)
                                          }.withoutNulls,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          imageItem,
                                          width: 168.0,
                                          height: 176.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }).divide(const SizedBox(width: 8,)),
                                ),
                              );
                            }
                        ),
                        FutureBuilder<UsersRecord>(
                            future: UsersRecord.getDocumentOnce(reviewRecord.reviewWrittenBy!),
                            builder: (context, asyncSnapshot) {
                              if(!asyncSnapshot.hasData){
                                return Text('찾을 수 없는 유저입니다.');
                              }
                              final UsersRecord userRecord = asyncSnapshot.data!;
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 36.0,
                                    height: 36.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      functions.basicProfile(userRecord.photoUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    userRecord
                                        .displayName,
                                    style:
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily:
                                      'PretendardSeries',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                      GoogleFonts
                                          .asMap()
                                          .containsKey(
                                          'PretendardSeries'),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                        Text(
                          reviewRecord.reviewTitle,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily:
                            'PretendardSeries',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 19.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: GoogleFonts
                                .asMap()
                                .containsKey(
                                'PretendardSeries'),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          reviewRecord.reviewText,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily:
                            'PretendardSeries',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14.0,
                            lineHeight: 1.2,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts
                                .asMap()
                                .containsKey(
                                'PretendardSeries'),
                          ),
                        )
                      ].divide(const SizedBox(height: 8.0)),
                    ),
                  ),
                );
              }
            }
          ),
        ),
      ),
    );
  }
}
