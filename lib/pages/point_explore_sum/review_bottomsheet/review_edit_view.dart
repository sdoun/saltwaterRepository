import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/review_bottomsheet/review_edit_controller.dart';

import '../../../auth/firebase_auth/auth_util.dart';
import '../../../backend/schema/t_b_user_review_point_record.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../reusable/pointDetailed/review_textform.dart';

class ReviewEditView extends StatefulWidget {
  const ReviewEditView({super.key, required this.reviewRef,});
  final DocumentReference reviewRef;

  @override
  State<ReviewEditView> createState() => _ReviewEditViewState();
}

class _ReviewEditViewState extends State<ReviewEditView> {
  late ReviewEditController _controller;
  late Future<TBUserReviewPointRecord?> _recordFuture;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _controller = ReviewEditController(reviewRef: widget.reviewRef);
    print('reviewEdit reviewRef: ${widget.reviewRef.toString()}');
    _recordFuture = loadReviewData();
  }

  Future<TBUserReviewPointRecord?> loadReviewData() async {
    try {
      DocumentSnapshot snapshot = await widget.reviewRef.get();
      if (!snapshot.exists) {
        print('Document does not exist');
        return null;
      }
      return TBUserReviewPointRecord.fromSnapshot(snapshot);
    } catch (e) {
      print('Error loading review data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recordFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          else if(snapshot.hasData){
            final record = snapshot.data!;
            _controller.updateModelByController(initialTitle: record.reviewTitle, initialContent: record.reviewText);
            return Material(
              color: Colors.transparent,
              elevation: 5.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 370.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                              child: Container(
                                width: 50.0,
                                height: 4.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                          child: Text(
                            '  리뷰 수정하기',
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                              fontFamily:
                              'PretendardSeries',
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  'PretendardSeries'),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 120.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.network(
                                  currentUserPhoto,
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    currentUserDisplayName,
                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                      fontFamily:
                                      'PretendardSeries',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                                          'PretendardSeries'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ReviewTextform(
                          controller: _controller.titleController,
                          focusNode: _controller.titleFocusNode,
                          validator: _controller.contentValidator,
                          hintText: '제목을 입력해주세요.',
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                          child: ReviewTextform(
                            controller: _controller.contentController,
                            focusNode: _controller.contetnFocusNode,
                            validator: _controller.contentValidator,
                            hintText: '내용을 입력해주세요.',
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 44.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _controller.updatePointReview();
                                  Navigator.pop(context);
                                },
                                text: '작성 완료',
                                options: FFButtonOptions(
                                  width: 150.0,
                                  height: 30.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily:
                                    'PretendardSeries',
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                                        'PretendardSeries'),
                                  ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(const SizedBox(height: 8.0)),
                    ),
                  ),
                ),
              ),
            );
          }
          else{
            return SizedBox();
          }
        }
    );
  }
}
