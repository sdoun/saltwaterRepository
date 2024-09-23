import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/components/un_read_chat_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/point_explore_sum/point_category/point_category_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home1_model.dart';
export 'home1_model.dart';

import 'package:salt_water_beta_ver1/reusable/home1/pointButton.dart';
import 'package:salt_water_beta_ver1/reusable/home1/fishButton.dart';
import 'package:salt_water_beta_ver1/reusable/home1/homeAdsPageView.dart';

class Home1Widget extends StatefulWidget {
  const Home1Widget({super.key});

  @override
  State<Home1Widget> createState() => _Home1WidgetState();
}

class _Home1WidgetState extends State<Home1Widget> {
  late Home1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Home1Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final PageController adsController = PageController(
      initialPage: 0,
    );
    return StreamBuilder<List<TBChatRoomRecord>>(
      stream: queryTBChatRoomRecord(
        queryBuilder: (tBChatRoomRecord) => tBChatRoomRecord.where(
          'room_participants',
          arrayContains: currentUserReference,
        ),
      ),
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
        List<TBChatRoomRecord> home1TBChatRoomRecordList = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    12, 0, 0, 0
                  ),
                child: Image.asset('assets/images/KakaoTalk_20240913_183755149.png'),
              ),
              title: Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: StreamBuilder<List<TBChatRecord>>(
                  stream: queryTBChatRecord(
                    queryBuilder: (tBChatRecord) => tBChatRecord
                        .where(
                          'chat_isRead',
                          isEqualTo: false,
                        )
                        .whereIn(
                            'chat_chatRoom',
                            home1TBChatRoomRecordList
                                .map((e) => e.reference)
                                .toList())
                        .where(
                          'chat_createdBy',
                          isNotEqualTo: currentUserReference,
                        ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return const Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 36.0,
                        ),
                      );
                    }
                    List<TBChatRecord> badgeTBChatRecordList = snapshot.data!;

                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return WebViewAware(
                              child: GestureDetector(
                                onTap: () => FocusScope.of(context).unfocus(),
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: SizedBox(
                                    height: 480.0,
                                    child: UnReadChatWidget(
                                      unReadChat: badgeTBChatRecordList
                                          .map((e) => e.reference)
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      child: badges.Badge(
                        badgeContent: Text(
                          valueOrDefault<String>(
                            badgeTBChatRecordList.length.toString(),
                            '0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                        ),
                        showBadge: true,
                        shape: badges.BadgeShape.circle,
                        badgeColor: FlutterFlowTheme.of(context).primary,
                        elevation: 4.0,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4.0, 8.0, 4.0, 8.0),
                        position: badges.BadgePosition.topEnd(),
                        animationType: badges.BadgeAnimationType.scale,
                        toAnimate: true,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: 36.0,
                            height: 36.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/q3052_.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('Checkout1');
                      },
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/aqdbq_.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.menu,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('menu');
                      },
                    ),
                  ],
                ),
              ],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: 100.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 24.0, 12.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1.0, -1.0),
                                          child: Text(
                                            '포인트별 검색하기',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      'PretendardSeries',
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          'PretendardSeries'),
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.local_fire_department_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .accent1,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00F4F6FF),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                pointButton(
                                                    text: '방파제\n&선착장',
                                                    ontap: () async {
                                                      context.pushNamed(
                                                          'exploreMapSW');
                                                    },
                                                    image: Image.asset(
                                                      'assets/images/방파제.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                ),
                                                pointButton(
                                                  text: '낚시공원',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'fishingParkMap');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/낚시공원.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                pointButton(
                                                  text: '해변&\n갯바위',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMapOcean');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/해변.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                pointButton(
                                                  text: '해상펜션\n&좌대',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMap_stand');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/해상펜션.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                pointButton(
                                                  text: '낚시펜션\n&민박',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMapFishingPension');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/낚시펜션.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ].divide(const SizedBox(height: 7.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 8.0, 12.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1.0, -1.0),
                                          child: Text(
                                            '어종별 검색하기',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      'PretendardSeries',
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          'PretendardSeries'),
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.settings_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 16.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00F4F6FF),
                                        ),
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Fishbutton(
                                                text: '돔',
                                                image: Image.asset('assets/images/돔.png'),
                                            ),
                                            Fishbutton(
                                              text: '두족류',
                                              image: Image.asset('assets/images/두족류.png'),
                                            ),
                                            Fishbutton(
                                              text: '중상층',
                                              image: Image.asset('assets/images/중상층.png'),
                                            ),
                                            Fishbutton(
                                              text: '원투낚시',
                                              image: Image.asset('assets/images/원투낚시.png'),
                                            ),
                                          ].divide(const SizedBox(width: 8.0)),
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
                      const Homeadspageview(
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: wrapWithModel(
                        model: _model.customNavbarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const CustomNavbarWidget(),
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