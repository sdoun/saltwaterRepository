import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_page_model.dart';
export 'user_page_model.dart';

class UserPageWidget extends StatefulWidget {
  const UserPageWidget({super.key});

  @override
  State<UserPageWidget> createState() => _UserPageWidgetState();
}

class _UserPageWidgetState extends State<UserPageWidget> {
  late UserPageModel _model;
  List<Widget>? pointReviews;
  int reviewLimit = 3;
  int postLimit = 3;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget? pointReviewBuilder(TBUserReviewPointRecord reviewRecord){
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          'point_detailed',
          queryParameters: {
            'pointRefSW': serializeParam(
              reviewRecord
                  .parentReference,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:
          FlutterFlowTheme.of(context)
              .primaryBackground,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional
              .fromSTEB(10.0, 8.0, 10.0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                reviewRecord
                    .reviewTitle,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight:
                  FontWeight.w600,
                  useGoogleFonts:
                  GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
              Text(
                currentUserDisplayName,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  letterSpacing: 0.0,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  useGoogleFonts:
                  GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
              Text(
                reviewRecord
                    .reviewText,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  letterSpacing: 0.0,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  useGoogleFonts:
                  GoogleFonts
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
  }
  List<Widget> reviewListBuilder(List<TBUserReviewPointRecord>? list){
    pointReviews = [];
    if(list != null){
      if(list.length <reviewLimit){
        for(int i = 0; i<list.length; i++){
          pointReviews?.add(pointReviewBuilder(list[i])!);
        }
      }
      else{
        for(int i = 0; i<reviewLimit; i++){
          pointReviews?.add(pointReviewBuilder(list[i])!);
        }
      }
      return pointReviews!;
    }
    else{
      return [const SizedBox(height: 42,)];
    }
  }
  Widget? carrotPostBuilder(TBCarrotPostRecord carrotPost){
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          'carrotPost',
          queryParameters: {
            'carrotPost': serializeParam(
              carrotPost
                  .reference,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:
          FlutterFlowTheme.of(context)
              .primaryBackground,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional
              .fromSTEB(10.0, 8.0, 10.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                carrotPost
                    .postTitle,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight:
                  FontWeight.w600,
                  useGoogleFonts:
                  GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
              Text(
                carrotPost.postCategory,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  letterSpacing: 0.0,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  useGoogleFonts:
                  GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
              Text(
                carrotPost
                    .postDatetime.toString() ?? '카테고리 미지정',
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  letterSpacing: 0.0,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  useGoogleFonts:
                  GoogleFonts
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
  }
  List<Widget> postListBuilder(List<TBCarrotPostRecord>? list){
    pointReviews = [];
    if(list != null){
      if(list.length <reviewLimit){
        for(int i = 0; i<list.length; i++){
          pointReviews?.add(carrotPostBuilder(list[i])!);
        }
      }
      else{
        for(int i = 0; i<reviewLimit; i++){
          pointReviews?.add(carrotPostBuilder(list[i])!);
        }
      }
      return pointReviews!;
    }
    else{
      return [const SizedBox(height: 42,)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: 586.0,
                      height: 356.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AuthUserStreamWidget(
                              builder: (context) {
                                if(currentUserPhoto.isEmpty){
                                  return Container(
                                      width: 80.0,
                                      height: 80.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                          'assets/images/기본프사.png',
                                          fit: BoxFit.cover
                                      ),
                                  );
                                }
                                return Container(
                                    width: 80.0,
                                    height: 80.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      currentUserPhoto,
                                      fit: BoxFit.fill,
                                    ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Text(
                                  currentUserDisplayName,
                                  style: FlutterFlowTheme.of(
                                      context)
                                      .bodyMedium
                                      .override(
                                    fontFamily:
                                    'PretendardSeries',
                                    color: FlutterFlowTheme
                                        .of(context)
                                        .primary,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight:
                                    FontWeight.w700,
                                    useGoogleFonts:
                                    GoogleFonts
                                        .asMap()
                                        .containsKey(
                                        'PretendardSeries'),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                child: Container(
                                  width: 69.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 6.0, 0.0, 6.0),
                                      child: Text(
                                        '[회원등급]',
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily:
                                          'PretendardSeries',
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .primary,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                          FontWeight.w600,
                                          useGoogleFonts:
                                          GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              'PretendardSeries'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 24.0, 24.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'userEdit',
                                    queryParameters: {
                                      'userRef': serializeParam(
                                        currentUserReference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text: '프로필 편집',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'PretendardSeries',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            'PretendardSeries'),
                                      ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 12.0, 24.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await actions.logoutKakao();
                                  GoRouter.of(context).prepareAuthEvent();
                                  await authManager.signOut();
                                  GoRouter.of(context).clearRedirectLocation();

                                  context.goNamedAuth('login', context.mounted);
                                },
                                text: '로그아웃',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'PretendardSeries',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                        'PretendardSeries'),
                                  ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100.0,
                      height: 271.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 0.0, 12.0),
                              child: Text(
                                '내 포인트',
                                style: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: FlutterFlowTheme
                                      .of(context)
                                      .primaryText,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w700,
                                  useGoogleFonts:
                                  GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 12.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.85,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE9E9E9),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(5.0),
                                ),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('service_is_not_ready');
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 15.0),
                                      child: Text(
                                        '[Point]',
                                        style: FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily:
                                          'PretendardSeries',
                                          color: const Color(0xff4CAAF5),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                          FontWeight.w700,
                                          useGoogleFonts:
                                          GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              'PretendardSeries'),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 15.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      48.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                '적립예정: ',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'PretendardSeries',
                                                  color: const Color(0xff949595),
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  useGoogleFonts:
                                                  GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      'PretendardSeries'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '[point2]',
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily:
                                              'PretendardSeries',
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FontWeight.w400,
                                              useGoogleFonts:
                                              GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  'PretendardSeries'),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    14.0, 0.0, 10.0, 0.0),
                                            child: Text(
                                              '|',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color:
                                                            const Color(0xFF949595),
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                      ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed('service_is_not_ready');
                                              },
                                              text: '적립내역보기  >',
                                              options: FFButtonOptions(
                                                height: 24,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    (MediaQuery.of(context).size.width * 0.05).clamp(0, 40), 0, (MediaQuery.of(context).size.width * 0.05).clamp(0, 40), 0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: const Color(0xFFE9E9E9),
                                                textStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleSmall
                                                      .override(
                                                    fontFamily:
                                                    'PretendardSeries',
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    useGoogleFonts:
                                                    GoogleFonts
                                                        .asMap()
                                                        .containsKey(
                                                        'PretendardSeries'),
                                                  ),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 6.0, 24.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('service_is_not_ready');
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(7.0),
                                  bottomRight: Radius.circular(7.0),
                                  topLeft: Radius.circular(7.0),
                                  topRight: Radius.circular(7.0),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  height: 71.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(
                                        context).secondaryBackground,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(7.0),
                                      bottomRight: Radius.circular(7.0),
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0),
                                    ),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('service_is_not_ready');
                                    },
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 0.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () {
                                                context.pushNamed('service_is_not_ready');
                                              },
                                              text: '이용 가이드 GUIDE',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                textStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'PretendardSeries',
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryText,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  useGoogleFonts:
                                                  GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      'PretendardSeries'),
                                                ),
                                                elevation: 0.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 24.0, 8.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: const Color(0x004B39EF),
                                              borderRadius: 20.0,
                                              borderWidth: 1.0,
                                              buttonSize: 40.0,
                                              fillColor: const Color(0xFF4CAAF5),
                                              icon: Icon(
                                                Icons.insert_comment,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                size: 24.0,
                                              ),
                                              onPressed: () {
                                                context.pushNamed('service_is_not_ready');
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 12.0),
                              child: Text(
                                '내가 작성한 리뷰',
                                style: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: FlutterFlowTheme
                                      .of(context)
                                      .primary,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w600,
                                  useGoogleFonts:
                                  GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            margin: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 24),
                            child: StreamBuilder<List<TBUserReviewPointRecord>>(
                              stream: queryTBUserReviewPointRecord(
                                queryBuilder: (tBUserReviewPointRecord) =>
                                    tBUserReviewPointRecord.where(
                                  'review_written_by',
                                  isEqualTo: currentUserReference,
                                ),
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
                                List<TBUserReviewPointRecord>
                                    listViewTBUserReviewPointRecordList =
                                    snapshot.data!;

                                return Column(
                                  children: reviewListBuilder(listViewTBUserReviewPointRecordList).divide(const SizedBox(height: 32,))
                                );
                              },
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                reviewLimit = reviewLimit + 10;
                              });
                            },
                            child: IntrinsicWidth(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme
                                        .of(context)
                                        .primaryBackground,
                                    borderRadius:
                                    BorderRadius.circular(
                                        12.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                  padding: const EdgeInsetsDirectional.only(start: 12, end: 8, top: 4, bottom: 4),
                                  alignment:
                                  const AlignmentDirectional(
                                      -1.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '더보기',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily:
                                          'PretendardSeries',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                                              'PretendardSeries'),
                                        ),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .secondaryText,
                                        size: 14,
                                      )
                                    ],
                                  )
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0,
                          20.0,
                          20.0,
                          valueOrDefault<double>(
                            MediaQuery.sizeOf(context).height * 0.08,
                            0.0,
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: Text(
                                '내가 작성한 게시물',
                                style: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: FlutterFlowTheme
                                      .of(context)
                                      .primary,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w600,
                                  useGoogleFonts:
                                  GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder<List<TBCarrotPostRecord>>(
                            stream: queryTBCarrotPostRecord(
                              queryBuilder: (tBCarrotPostRecord) =>
                                  tBCarrotPostRecord.where(
                                'post_seller',
                                isEqualTo: currentUserReference,
                              ),
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
                              List<TBCarrotPostRecord>
                                  columnTBCarrotPostRecordList = snapshot.data!;

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: postListBuilder(columnTBCarrotPostRecordList).divide(const SizedBox(height: 16,)),
                              );
                            },
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                postLimit = postLimit + 10;
                                print(postLimit);
                              });
                            },
                            child: IntrinsicWidth(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme
                                        .of(context)
                                        .primaryBackground,
                                    borderRadius:
                                    BorderRadius.circular(
                                        12.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                  padding: const EdgeInsetsDirectional.only(start: 12, end: 8, top: 4, bottom: 4),
                                  alignment:
                                  const AlignmentDirectional(
                                      -1.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '더보기',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily:
                                          'PretendardSeries',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                                              'PretendardSeries'),
                                        ),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .secondaryText,
                                        size: 14,
                                      )
                                    ],
                                  )
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
  }
}
