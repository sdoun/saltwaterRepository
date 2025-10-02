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

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}



class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
          stream: queryTBUserReviewPointRecord(

          ),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: Text(
                    '리뷰를 불러오지 못했습니다.',
                ),
              );
            }
            else{
              final reviewList = snapshot.data ?? [];
              if(reviewList.isEmpty){
                return Center(
                  child: Text(
                    '리뷰가 없습니다.',
                  ),
                );
              }
              else{
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(reviewList.length, (index){
                          final review = reviewList[index];
                          return FutureBuilder(
                              future: TBPointRecord.getDocumentOnce(review.parentReference),
                              builder: (context, asyncSnapshot) {
                                if(!asyncSnapshot.hasData){
                                  return SizedBox(height: 0,);
                                }
                                final point = asyncSnapshot.data!;
                                return StreamBuilder(
                                  //여기서 BadState: No Element 에러 발생함
                                    stream: UsersRecord.getDocument(review.reviewWrittenBy!),
                                    builder: (context, snapshot){
                                      if(snapshot.hasError){
                                        print('snapshot error: ${snapshot.error}');
                                        return SizedBox(height: 8,);
                                      }
                                      else if(!snapshot.hasData){
                                        return SizedBox(height: 8,);
                                      }
                                      final containerUsersRecord = snapshot.data!;
                                      return Container(
                                        width: double.infinity,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 8.0, 8.0),
                                          child: InkWell(
                                            onTap: (){
                                              if(point.pointCategories == '체험낚시배' || point.pointCategories == '낚시배'){
                                                context.pushNamed(
                                                  'boat_detailed',
                                                  queryParameters: {
                                                    'pointRefSW': serializeParam(
                                                      point.reference,
                                                      ParamType.DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              }
                                              else {
                                                context.pushNamed('point_detailed', queryParameters: {
                                                  'pointRefSW': serializeParam(point.reference, ParamType.DocumentReference)
                                                }.withoutNulls);
                                              }
                                            },
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Container(
                                                    height: 88,
                                                    width: 88,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12)
                                                    ),
                                                    clipBehavior: Clip.antiAlias,
                                                    child: Image.network(
                                                      review.reviewImages.first,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          point.pointName,
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'PretendardSeries',
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w600,
                                                            useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                                .containsKey(
                                                                'PretendardSeries'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 16
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          review
                                                              .reviewTitle,
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'PretendardSeries',
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w400,
                                                            useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                                .containsKey(
                                                                'PretendardSeries'),

                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 32.0,
                                                              height: 32.0,
                                                              clipBehavior: Clip.antiAlias,
                                                              decoration: const BoxDecoration(
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: Image.network(
                                                                functions.basicProfile(containerUsersRecord.photoUrl),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Container(
                                                              constraints: BoxConstraints(
                                                                maxWidth: 72
                                                              ),
                                                              child: Text(
                                                                '${containerUsersRecord
                                                                    .displayName}',
                                                                style:
                                                                FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'PretendardSeries',
                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400,
                                                                  letterSpacing: 0.0,
                                                                  useGoogleFonts:
                                                                  GoogleFonts
                                                                      .asMap()
                                                                      .containsKey(
                                                                      'PretendardSeries'),
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                            Text(
                                                              ' | ${review
                                                                  .timestamp?.year} - ${review
                                                                  .timestamp?.month} - ${review
                                                                  .timestamp?.day}',
                                                              style:
                                                              FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'PretendardSeries',
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                                letterSpacing: 0.0,
                                                                useGoogleFonts:
                                                                GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    'PretendardSeries'),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                  ].divide(const SizedBox(height: 8.0)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                          );
                        })
                      ),
                    ),
                  )
                );
              }
            }
          }
      ),
    );
  }
}
