import 'package:salt_water_beta_ver1/components/chatFAB.dart';
import 'package:salt_water_beta_ver1/reusable/home1/pointAdsPageview.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../reusable/common/appOffBottomSheet.dart';
import '../../reusable/common/pulsatingImage.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  final _adsLength = 5;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Home1Model());
    FFAppState().fishes.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    loadPointAds();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> loadPointAds() async{
    setState(() {
      _isLoading = true;
    });

    Query query = _firestore.collection('TB_pointAds').orderBy('timestamp', descending: true).limit(_adsLength);
    QuerySnapshot querySnapshot = await query.get();
    FFAppState().pointAds = querySnapshot;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
          final shouldpop = await showModalBottomSheet<bool>(
          context: context,
          builder: (context){
            return const WebViewAware(
                child: Appoffbottomsheet()
            );
          }
        );
          return shouldpop ?? false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leadingWidth: 180.0,
            leading: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  12, 0, 0, 0
              ),
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 48,
                        child: Image.asset('assets/images/상단바로고1.png')
                    ),
                  ],
                ),
              ),
            ),
            title: const Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
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
                      context.pushNamed('service_is_not_ready');
                    },
                    child: Container(
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                              child: Image.asset(
                                'assets/images/q3052_.png',
                                height: 36,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: badges.Badge(
                                  badgeContent: Text(
                                    '0',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      fontSize: 12,
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
                                  const EdgeInsetsDirectional.fromSTEB(3.0, 3.0, 3.0, 3.0),
                                  position: badges.BadgePosition.topEnd(),
                                  animationType: badges.BadgeAnimationType.scale,
                                  toAnimate: true,
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed('service_is_not_ready');
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
                                    '검색어를 입력해주세요.',
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
                                    context.pushNamed('homeSearchPage', queryParameters: {'searchText':_model.textController.text});
                                  },
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/검색옅은색.png',
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
                                12.0, 0.0, 12.0, 0.0),
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
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w800,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/포인트별검색2.png',
                                        width: 24,
                                        height: 24,
                                      )
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
                                                text: '방파제',
                                                secondText: '선착장',
                                                ontap: () async {
                                                  context.pushNamed(
                                                      'exploreMapSW');
                                                },
                                                image: Image.asset(
                                                  'assets/images/1007방파제.png',
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
                                                  'assets/images/1007낚시공원.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              pointButton(
                                                text: '해변',
                                                secondText: '갯바위',
                                                ontap: () async {
                                                  context.pushNamed(
                                                      'exploreMapOcean');
                                                },
                                                image: Image.asset(
                                                  'assets/images/1007해변.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              pointButton(
                                                text: '해상펜션',
                                                secondText: '좌대',
                                                ontap: () async {
                                                  context.pushNamed(
                                                      'exploreMap_stand');
                                                },
                                                image: Image.asset(
                                                  'assets/images/1007해상펜션.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              pointButton(
                                                text: '낚시펜션',
                                                secondText: '민박',
                                                ontap: () async {
                                                  context.pushNamed(
                                                      'exploreMapFishingPension');
                                                },
                                                image: Image.asset(
                                                  'assets/images/1007민박.png',
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
                                12.0, 36.0, 12.0, 0.0),
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
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w800,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/전문가용낚시.png',
                                        width: 30,
                                        height: 30,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 32.0),
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
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Fishbutton(
                                            text: '돔',
                                            image: Image.asset('assets/images/감성돔_리사이즈.png'),
                                          ),
                                          Fishbutton(
                                            text: '두족류',
                                            image: Image.asset('assets/images/무늬오징어_리사이즈.png'),
                                          ),
                                          Fishbutton(
                                            text: '중상층',
                                            image: Image.asset('assets/images/전갱이_리사이즈.png'),
                                          ),
                                          Fishbutton(
                                            text: '원투낚시',
                                            image: Image.asset('assets/images/광어_리사이즈.png'),
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

                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 36),
                      child: PointAdsPageview(
                        data: FFAppState().pointAds,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
                if(_isLoading)
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Opacity(
                      opacity: 0.6,
                      child: Container(
                        color: FlutterFlowTheme.of(context).primaryText,
                        child: const Center(
                          child: SizedBox(
                            height: 200,
                            child: PulsatingImage(),
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
          floatingActionButton: const ChatFab(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
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
      ),
    );
  }
}
