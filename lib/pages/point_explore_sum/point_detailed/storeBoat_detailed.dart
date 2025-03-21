import 'dart:io';

import 'package:salt_water_beta_ver1/pages/point_explore_sum/review_bottomsheet/review_edit_view.dart';
import 'package:salt_water_beta_ver1/reusable/common/report_bottomsheet.dart';

import '../../../reusable/common/basicScaffold.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/custom_code/actions/index.dart' as actions;
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/point_explore_sum/review_bottomsheet/review_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'point_detailed_model.dart';
export 'point_detailed_model.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:platform/platform.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';



class StoreboatDetailed extends StatefulWidget {
  const StoreboatDetailed({
    super.key,
    required this.pointRefSW,
  });

  final DocumentReference? pointRefSW;

  @override
  State<StoreboatDetailed> createState() => _PointDetailedWidgetState();
}

class _PointDetailedWidgetState extends State<StoreboatDetailed> {
  late PointDetailedModel _model;
  String haewoonLink = 'https://island.haewoon.co.kr/';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PointDetailedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _onOpen(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch $link');
    }
  }

  void openNavi(String address){
    final intent = AndroidIntent(
        action: 'action_view',
        data: "geo:0,0?q=$address"
    );
    intent.launch();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TBPointRecord>(
      stream: TBPointRecord.getDocument(widget.pointRefSW!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
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
                    '포인트 상세보기',
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
            body: Center(
                child: Text('포인트 정보를 불러오지 못했습니다.\n 인터넷 연결을 확인하거나 다시 접속해주세요.')
            ),
          );
        }

        final pointDetailedTBPointRecord = snapshot.data!;

        return Basicscaffold(
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
                  pointDetailedTBPointRecord.pointName,
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
            top: true,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height-40,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) {
                              final pointImages = pointDetailedTBPointRecord
                                  .pointImages
                                  .toList();

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(pointImages.length,
                                          (pointImagesIndex) {
                                        final pointImagesItem =
                                        pointImages[pointImagesIndex];
                                        return InkWell(
                                          onTap: () async {
                                            context.pushNamed(
                                              'photoViewPage',
                                              queryParameters: {
                                                'imageList': serializeParam(
                                                  pointDetailedTBPointRecord
                                                      .pointImages,
                                                  ParamType.String,
                                                  isList: true,
                                                ),
                                                'currentIndex' : serializeParam(pointImagesIndex, ParamType.int, isList: false)
                                              }.withoutNulls,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.network(
                                              pointImagesItem,
                                              width: 168.0,
                                              height: 176.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).divide(const SizedBox(width: 8.0)),
                                ),
                              );
                            },
                          ),
                          Row(
                              children: [
                                Text(
                                  pointDetailedTBPointRecord.pointName,
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
                                ToggleIcon(
                                  onPressed: () async {
                                    final pointLikedByElement =
                                        currentUserReference;
                                    final pointLikedByUpdate =
                                    pointDetailedTBPointRecord.pointLikedBy
                                        .contains(pointLikedByElement)
                                        ? FieldValue.arrayRemove(
                                        [pointLikedByElement])
                                        : FieldValue.arrayUnion(
                                        [pointLikedByElement]);
                                    await pointDetailedTBPointRecord.reference
                                        .update({
                                      ...mapToFirestore(
                                        {
                                          'point_liked_by': pointLikedByUpdate,
                                        },
                                      ),
                                    });
                                  },
                                  value: pointDetailedTBPointRecord.pointLikedBy
                                      .contains(currentUserReference),
                                  onIcon: FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: FlutterFlowTheme.of(context).error,
                                    size: 20.0,
                                  ),
                                  offIcon: FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: FlutterFlowTheme.of(context).error,
                                    size: 20.0,
                                  ),
                                ),

                              ]
                          ),

                          Flexible(
                            child: Row(
                              children: [
                                Text(
                                  pointDetailedTBPointRecord.pointAddress,
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
                                ),
                                const SizedBox(
                                    width: 8
                                ),
                                InkWell(
                                  onTap: () async{
                                    openNavi(pointDetailedTBPointRecord.pointAddress);
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 13,
                                        child: Image.asset('assets/images/길찾기.png'),
                                      ),
                                      Text(
                                        '길찾기',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily:
                                          'PretendardSeries',
                                          color: FlutterFlowTheme.of(context).primary,
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w400,
                                          useGoogleFonts: GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              'PretendardSeries'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                if(pointDetailedTBPointRecord.isIsland ?? false)
                                  InkWell(
                                    onTap: () async{
                                      _onOpen(haewoonLink);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          child: Image.asset('assets/images/배편보기.png'),
                                        ),
                                        Text(
                                          '배편 예약',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color: FlutterFlowTheme.of(context).primary,
                                            fontSize: 13.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w400,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ].divide(const SizedBox(height: 8.0)),

                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                              child: Text(
                                '최신업데이트 ${DateFormat("yyyy.MM.dd").format(DateTime.now().add(Duration(days: -7)))}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 12.0,
                                  lineHeight: 1.2,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w400,
                                  useGoogleFonts: GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(minHeight: 100),
                            color: const Color(0xffeeeeee),
                            child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 18, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pointDetailedTBPointRecord.pointCategories == '낚시배' ? '낚시배 소개' : '낚시방 소개',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'PretendardSeries',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts
                                            .asMap()
                                            .containsKey(
                                            'PretendardSeries'),
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 20.0, 16.0, 20.0),
                                        child:
                                        Linkify(
                                          onOpen:  (link) async {
                                            if (!await launchUrl(Uri.parse(link.url))) {
                                              throw Exception('Could not launch ${link.url}');
                                            }
                                          },
                                          text:
                                          pointDetailedTBPointRecord
                                              .pointIntroduction.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                          linkStyle: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color: FlutterFlowTheme.of(context).primary,
                                            decoration: TextDecoration.underline,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                      ),)
                                  ],
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 24.0, 16.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('특이사항: ',
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
                                            ),
                                            Flexible(
                                              child: Linkify(
                                                onOpen: (link) async {
                                                  if (!await launchUrl(Uri.parse(link.url))) {
                                                    throw Exception('Could not launch ${link.url}');
                                                  }
                                                },
                                                text: pointDetailedTBPointRecord.pointSpecialNote,
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
                                              ),)
                                          ],
                                        )
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 4.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '회원의견보기',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily:
                                    'PretendardSeries',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts
                                        .asMap()
                                        .containsKey(
                                        'PretendardSeries'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return WebViewAware(
                                          child: GestureDetector(
                                            onTap: () =>
                                                FocusScope.of(context).unfocus(),
                                            child: Padding(
                                              padding:
                                              MediaQuery.viewInsetsOf(context),
                                              child: SizedBox(
                                                height: 520.0,
                                                child: ReviewBottomsheetWidget(
                                                  reviewPointRef:
                                                  widget.pointRefSW!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: IntrinsicWidth(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .primary,
                                        borderRadius:
                                        BorderRadius.circular(
                                            12.0),
                                      ),
                                      padding: const EdgeInsetsDirectional.only(start: 4, end: 8, top: 4, bottom: 4),
                                      alignment:
                                      const AlignmentDirectional(
                                          0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            size: 16,
                                            Icons.create_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                              height: 20,
                                              child: Align(
                                                alignment: const Alignment(0, 0),
                                                child: Text(
                                                    '의견쓰기',
                                                    style: GoogleFonts.getFont(
                                                      'Readex Pro',
                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13.0,
                                                      height: 1.1,
                                                    )
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance.doc(widget.pointRefSW!.path).collection('/TB_userReview_point').get(),
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
                          List<TBUserReviewPointRecord>
                          columnTBUserReviewPointRecordList =
                          snapshot.data!.docs.map((doc){
                            return TBUserReviewPointRecord.fromSnapshot(doc);
                          }).toList();

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                columnTBUserReviewPointRecordList.length,
                                    (columnIndex) {
                                  final columnTBUserReviewPointRecord =
                                  columnTBUserReviewPointRecordList[
                                  columnIndex];
                                  print('리뷰 길이 = ${columnTBUserReviewPointRecordList.length}');
                                  return StreamBuilder<UsersRecord>(
                                    stream: UsersRecord.getDocument(
                                        columnTBUserReviewPointRecord
                                            .reviewWrittenBy!),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return const Center(
                                        );
                                      }

                                      final containerUsersRecord = snapshot.data!;

                                      return Visibility(
                                        visible: !((columnTBUserReviewPointRecord.reviewReportedBy.contains(currentUserReference)) || currentUserDocument!.bannedUser.contains(columnTBUserReviewPointRecord
                                            .reviewWrittenBy!)),
                                        child: Container(
                                          width: double.infinity,
                                          height: 124.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                8.0, 8.0, 8.0, 8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      columnTBUserReviewPointRecord
                                                          .reviewTitle,
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
                                                    Row(
                                                      children: [
                                                        Visibility(
                                                            visible: currentUserReference == containerUsersRecord.reference,
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () async {
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled: true,
                                                                      backgroundColor: Colors.transparent,
                                                                      enableDrag: false,
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return WebViewAware(
                                                                          child: GestureDetector(
                                                                            onTap: () =>
                                                                                FocusScope.of(context).unfocus(),
                                                                            child: Padding(
                                                                              padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                              child: SizedBox(
                                                                                  height: 520.0,
                                                                                  child: ReviewEditView(
                                                                                    reviewRef: columnTBUserReviewPointRecord.reference,
                                                                                  )
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) => safeSetState(() {}));
                                                                  },
                                                                  child: SizedBox(
                                                                    height: 24,
                                                                    child: Image.asset('assets/images/리뷰수정.png'),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    columnTBUserReviewPointRecord.deleteRecord(columnTBUserReviewPointRecord.reference);
                                                                  },
                                                                  child:
                                                                  SizedBox(
                                                                    height: 24,
                                                                    child: Image.asset('assets/images/리뷰삭제.png'),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                        ),
                                                        InkWell(
                                                            onTap: () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled: true,
                                                                backgroundColor: Colors.transparent,
                                                                enableDrag: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return WebViewAware(
                                                                    child: GestureDetector(
                                                                      onTap: () =>
                                                                          FocusScope.of(context).unfocus(),
                                                                      child: Padding(
                                                                        padding:
                                                                        MediaQuery.viewInsetsOf(context),
                                                                        child: SizedBox(
                                                                          height: 520.0,
                                                                          child: ReportBottomsheet(
                                                                            reviewRef: columnTBUserReviewPointRecord.reference,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) => safeSetState(() {}));
                                                            },
                                                            child: SizedBox(
                                                                height: 24,
                                                                child: Image.asset('assets/images/낚시경보.png')
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
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
                                                        functions.basicProfile(containerUsersRecord.photoUrl),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      containerUsersRecord
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
                                                ),
                                                Text(
                                                  columnTBUserReviewPointRecord
                                                      .reviewText,
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
                                                ),
                                              ].divide(const SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                  ].divide(const SizedBox(height: 12.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
