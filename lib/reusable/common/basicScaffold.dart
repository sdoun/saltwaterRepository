import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/chatFAB.dart';
import '../../components/custom_navbar_widget.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class Basicscaffold extends StatelessWidget {
  const Basicscaffold({super.key, this.body, this.appBar});

  final Widget? body;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: appBar ?? AppBar(
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
      body: body,
      //floatingActionButton: const ChatFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.12,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: const CustomNavbarWidget(),
      ),
    );
  }
}
