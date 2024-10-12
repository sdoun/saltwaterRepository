import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class Menuiconbutton extends StatelessWidget {
  const Menuiconbutton({super.key, required this.imageRoute, required this.text, this.onTap});

  final String imageRoute;
  final String text;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
              .primaryBackground,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              8.0, 4.0, 8.0, 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:
                MediaQuery.sizeOf(context).width *
                    0.125,
                height:
                MediaQuery.sizeOf(context).width *
                    0.125,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imageRoute,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                text,
                style: FlutterFlowTheme.of(
                    context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  color: FlutterFlowTheme
                      .of(context)
                      .primaryText,
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
            ].divide(const SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
