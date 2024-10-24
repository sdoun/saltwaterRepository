import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu_model.dart';
export 'menu_model.dart';

import 'package:salt_water_beta_ver1/reusable/menu/menuIconButton.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late MenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                '더 보 기',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'PretendardSeries',
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w800,
                      useGoogleFonts:
                          GoogleFonts.asMap().containsKey('PretendardSeries'),
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 44.0, 36.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Menuiconbutton(
                                imageRoute: 'assets/images/공지사항.png',
                                text: '공지사항',
                                onTap: () async{
                                    context.pushNamed('service_is_not_ready');
                                },
                            ),
                            Menuiconbutton(
                              imageRoute: 'assets/images/이벤트.png',
                              text: '이벤트',
                              onTap: () async{
                                context.pushNamed('service_is_not_ready');
                              },
                            ),
                            Menuiconbutton(
                              imageRoute: 'assets/images/낚시대회.png',
                              text: '낚시대회',
                              onTap: () async{
                                context.pushNamed('service_is_not_ready');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Menuiconbutton(
                              imageRoute: 'assets/images/낚시경보.png',
                              text: '낚시경보',
                              onTap: () async{
                                context.pushNamed('service_is_not_ready');
                              },
                            ),
                            Menuiconbutton(
                              imageRoute: 'assets/images/금어기.png',
                              text: '금어기',
                              onTap: () async{
                                context.pushNamed('service_is_not_ready');
                              },
                            ),
                            Menuiconbutton(
                              imageRoute: 'assets/images/방생기준.png',
                              text: '방생기준',
                              onTap: () async{
                                context.pushNamed('service_is_not_ready');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: 72.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3F3F3),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '업체 제휴 문의',
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'PretendardSeries',
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .primaryText,
                                        fontSize: 16.0,
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
                                    Text(
                                      '제휴 및 통보',
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'PretendardSeries',
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .secondaryText,
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
                                  ].divide(const SizedBox(height: 4.0)),
                                ),
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
                                width: MediaQuery.sizeOf(context).width * 0.43,
                                height: 72.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3F3F3),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '서비스 문의',
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'PretendardSeries',
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .primaryText,
                                        fontSize: 16.0,
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
                                    Text(
                                      '이용문의 & 불편사항 신고',
                                      style: FlutterFlowTheme.of(
                                          context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'PretendardSeries',
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .secondaryText,
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
                                  ].divide(const SizedBox(height: 4.0)),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(width: 8.0)),
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
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: 72.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFFCAF1FA),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '서포터스 필드스텝 모집',
                              style: FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme
                                    .of(context)
                                    .primaryText,
                                fontSize: 16.0,
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
                            Text(
                              '실시간 조항, 포인트 개발, 현지상황 리포팅',
                              style: FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme
                                    .of(context)
                                    .secondaryText,
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
                          ].divide(const SizedBox(height: 4.0)),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 8.0)),
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
