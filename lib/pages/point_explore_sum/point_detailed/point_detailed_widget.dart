import 'dart:io';

import 'package:salt_water_beta_ver1/pages/point_explore_sum/review_bottomsheet/review_edit_view.dart';
import 'package:salt_water_beta_ver1/reusable/common/report_bottomsheet.dart';

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



class PointDetailedWidget extends StatefulWidget {
  const PointDetailedWidget({
    super.key,
    required this.pointRefSW,
  });

  final DocumentReference? pointRefSW;

  @override
  State<PointDetailedWidget> createState() => _PointDetailedWidgetState();
}

class _PointDetailedWidgetState extends State<PointDetailedWidget> {
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

        final pointDetailedTBPointRecord = snapshot.data!;

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
                child: ListView(
                  padding: EdgeInsets.zero,
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
                                          'imageDetailView',
                                          queryParameters: {
                                            'imageList': serializeParam(
                                              pointDetailedTBPointRecord
                                                  .pointImages,
                                              ParamType.String,
                                              isList: true,
                                            ),
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
                          InkWell(
                            onTap: ()async {
                              context.pushNamed(
                                'weatherDetailed',
                                queryParameters: {
                                  'weatherRef': serializeParam(
                                    await actions.findWeatherPoint(pointDetailedTBPointRecord.pointLatitude, pointDetailedTBPointRecord.pointLongitude),
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 36,
                                  child: Image.asset('assets/images/맑음2.png'),
                                ),
                                Text(
                                  '이곳의 날씨보기',
                                  style:
                                    FlutterFlowTheme.of(context)
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
                                    decoration: TextDecoration.underline
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: StreamBuilder<List<TBPointTagsRecord>>(
                              stream: queryTBPointTagsRecord(
                                queryBuilder: (tBPointTagsRecord) =>
                                    tBPointTagsRecord.whereIn('tag_name',
                                        pointDetailedTBPointRecord.pointTags),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<TBPointTagsRecord>
                                    containerTBPointTagsRecordList =
                                    snapshot.data!;

                                return Container(
                                  width: 347.0,
                                  height: 102.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final pointTags =
                                          containerTBPointTagsRecordList
                                              .toList();

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children:
                                              List.generate(pointTags.length,
                                                  (pointTagsIndex) {
                                            final pointTagsItem =
                                                pointTags[pointTagsIndex];
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 48.0,
                                                  height: 48.0,
                                                  clipBehavior:
                                                  Clip.antiAlias,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    pointTagsItem.tagIcon,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Text(
                                                  pointTagsItem.tagName,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'PretendardSeries',
                                                    letterSpacing: 0.0,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    useGoogleFonts:
                                                    GoogleFonts
                                                        .asMap()
                                                        .containsKey(
                                                        'PretendardSeries'),
                                                  ),
                                                ),
                                              ].divide(const SizedBox(height: 8.0)),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ].divide(const SizedBox(height: 8.0)),

                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 36.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, -1.0),
                            child: Text(
                              '주 어종',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap()
                                    .containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                            ),
                          ),
                          StreamBuilder<List<TBFishRecord>>(
                            stream: queryTBFishRecord(
                                queryBuilder: (tBFishRecord) {
                                  if (pointDetailedTBPointRecord.pointFishType.isEmpty) {
                                    return tBFishRecord.where('fish_name', isEqualTo: '전갱이');
                                  }
                                  return tBFishRecord
                                      .whereIn('fish_name', pointDetailedTBPointRecord.pointFishType)
                                      .orderBy('fish_num');
                                }
                            ),
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
                              List<TBFishRecord> containerTBFishRecordList =
                              List.from(snapshot.data!);

                              return Container(
                                margin: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                width: 563.0,
                                height: 92.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    final pointFishes =
                                    containerTBFishRecordList.toList();

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:
                                        List.generate(pointFishes.length,
                                                (pointFishesIndex) {
                                              final pointFishesItem =
                                              pointFishes[pointFishesIndex];
                                              return Container(
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 64.0,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                      ),
                                                      child: Image.network(
                                                        pointFishesItem.fishIcon,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      pointFishesItem.fishName,
                                                      style: FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'PretendardSeries',
                                                        letterSpacing: 0.0,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        useGoogleFonts:
                                                        GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            'PretendardSeries'),
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(height: 8.0)),
                                                ),
                                              );
                                            }
                                          ).divide(const SizedBox(width: 4.0,)),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
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
                                      '포인트 소개',
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
                                          0.0, 12.0, 16.0, 0.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '주변시설 : ',
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
                                            child: Text(
                                              pointDetailedTBPointRecord.pointArround,
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
                                          )
                                        ],
                                      )
                                    ),
                                  ),
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
                                            child: Text(
                                            pointDetailedTBPointRecord.pointSpecialNote,
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
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xffFEFFEF),
                            ),
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 18, 0, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, -1.0),
                                  child: Text(
                                    '추천 조법',
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
                                ),
                                StreamBuilder<List<TBFishingRecord>>(
                                  stream: queryTBFishingRecord(
                                    queryBuilder: (tBFishingRecord) =>
                                        tBFishingRecord.whereIn(
                                            'fishing_name',
                                            pointDetailedTBPointRecord
                                                .pointFishing),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<TBFishingRecord>
                                        containerTBFishingRecordList =
                                        snapshot.data!;

                                    return Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFEFFEF),
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          final pointFishing =
                                              containerTBFishingRecordList
                                                  .toList();

                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: List.generate(
                                                pointFishing.length,
                                                (pointFishingIndex) {
                                              final pointFishingItem =
                                                  pointFishing[
                                                      pointFishingIndex];
                                              return Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      pointFishingItem
                                                          .fishingName,
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'PretendardSeries',
                                                        letterSpacing: 0.0,
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        useGoogleFonts:
                                                        GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            'PretendardSeries'),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(height: 8.0)),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ].divide(const SizedBox(height: 4.0)),
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
                      child: StreamBuilder<List<TBUserReviewPointRecord>>(
                        stream: queryTBUserReviewPointRecord(
                          parent: widget.pointRefSW,
                          queryBuilder: (tbReviewRecord){
                            return tbReviewRecord.orderBy('timestamp', descending: true);
                          }
                        ),
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
                              snapshot.data!;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                columnTBUserReviewPointRecordList.length,
                                (columnIndex) {
                              final columnTBUserReviewPointRecord =
                                  columnTBUserReviewPointRecordList[
                                      columnIndex];
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
