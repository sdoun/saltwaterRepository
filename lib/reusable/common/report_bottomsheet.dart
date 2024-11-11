import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import '../../backend/schema/t_b_user_review_report_record.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../flutter_flow/form_field_controller.dart';
import '/backend/backend.dart';

import '../../auth/firebase_auth/auth_util.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:salt_water_beta_ver1/reusable/pointDetailed/review_textform.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class ReportBottomsheet extends StatefulWidget {
  const ReportBottomsheet({super.key, required this.reviewRef});

  final DocumentReference reviewRef;

  @override
  State<ReportBottomsheet> createState() => _ReportBottomsheetState();
}

class _ReportBottomsheetState extends State<ReportBottomsheet> {

  TextEditingController? titleController;

  FormFieldController<String> reportTypeController = FormFieldController<String>(null);

  String? reportType;

  @override
  void initState(){
    super.initState();
    titleController = titleController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: TBUserReviewPointRecord.getDocument(widget.reviewRef),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Container();
          }
          final reviewRecord = snapshot.data!;
          return Material(
        color: Colors.transparent,
        elevation:5.0,
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
                      '  리뷰 신고하기',
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
                            functions.basicProfile(currentUserPhoto),
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
                    controller: titleController,
                    hintText: '제목을 입력해주세요.',
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: FlutterFlowDropDown<String>(
                      controller: reportTypeController,
                      options: const [
                        '폭력적이거나 선정적인 콘텐츠',
                        '광고성 콘텐츠',
                        '포인트와 관련 없음',
                      ],
                      onChanged: (val) => safeSetState(
                              () => reportType = val),
                      width: 136.0,
                      height: 50.0,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'PretendardSeries',
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey('PretendardSeries'),
                      ),
                      hintText: '카테고리',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context)
                            .secondaryText,
                        size: 24.0,
                      ),
                      fillColor: FlutterFlowTheme.of(context)
                          .primaryBackground,
                      elevation: 2.0,
                      borderColor:
                      FlutterFlowTheme.of(context).secondaryText,
                      borderWidth: 2.0,
                      borderRadius: 8.0,
                      margin: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 4.0, 16.0, 4.0),
                      hidesUnderline: true,
                      isOverButton: true,
                      isSearchable: false,
                      isMultiSelect: false,
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
                            final reportedBy = reviewRecord.reviewReportedBy ?? [];
                            reportedBy.add(currentUserReference!);
                            await TBUserReviewReportRecord.collection.doc().set({
                              ...createTBUserReviewReportData(
                              reportTitle: titleController.text,
                              reportedBy: currentUserReference,
                            reportType: reportType,
                            reportedPost: reviewRecord.reference
                            )
                            });
                            widget.reviewRef.update({
                              'reported_by':reportedBy
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('신고가 완료되었습니다!')),
                            );
                            Navigator.pop(context);
                          },
                          text: '신고하기',
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
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 44.0),
                        child: FFButtonWidget(

                          onPressed: () async {
                            final bannedUser = reviewRecord.reviewWrittenBy;
                            final reportedBy = reviewRecord.reviewReportedBy ?? [];
                            reportedBy.add(currentUserReference!);
                            await TBUserReviewReportRecord.collection.doc().set({
                              ...createTBUserReviewReportData(
                                  reportTitle: titleController.text,
                                  reportedBy: currentUserReference,
                                  reportType: reportType,
                                  reportedPost: reviewRecord.reference
                              )
                            });
                            currentUserReference!.update({
                              'banned_user': bannedUser
                            });
                            widget.reviewRef.update({
                              'reported_by':reportedBy
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('신고가 완료되었습니다!')),
                            );
                            Navigator.pop(context);
                          },
                          text: '신고하고 사용자 차단하기',
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
    );
  }
}
