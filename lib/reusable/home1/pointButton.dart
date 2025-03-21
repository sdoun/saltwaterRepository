import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/backend/api_requests/api_calls.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class pointButton extends StatefulWidget {
  const pointButton({super.key, this.ontap, required this.text, this.image, this.secondText});
  final ontap;
  final String text;
  final String? secondText;
  final Widget? image;


  @override
  State<pointButton> createState() => _pointButtonState();
}

class _pointButtonState extends State<pointButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor:
      Colors.transparent,
      focusColor:
      Colors.transparent,
      hoverColor:
      Colors.transparent,
      highlightColor:
      Colors.transparent,
      onTap: widget.ontap,
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme
              .of(context)
              .primaryBackground,
          borderRadius:
          const BorderRadius.only(
            bottomLeft:
            Radius.circular(
                8.0),
            bottomRight:
            Radius.circular(
                8.0),
            topLeft:
            Radius.circular(
                8.0),
            topRight:
            Radius.circular(
                8.0),
          ),
        ),
        child: Padding(
          padding:
          const EdgeInsetsDirectional
              .fromSTEB(
              0.0,
              0.0,
              0.0,
              8.0),
          child: Column(
            mainAxisSize:
            MainAxisSize.min,
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery
                    .sizeOf(
                    context)
                    .width *
                    0.12,
                height: MediaQuery
                    .sizeOf(
                    context)
                    .width *
                    0.12,
                clipBehavior:
                Clip.antiAlias,
                decoration:
                const BoxDecoration(
                  shape: BoxShape
                      .circle,
                ),
                child: widget.image,
              ),
              const SizedBox(
                height: 8,
              ),
              AutoSizeText(
                widget.text,
                style: FlutterFlowTheme
                    .of(context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  fontSize:
                  14.0,
                  letterSpacing:
                  0.0,
                  fontWeight:
                  FontWeight
                      .w500,
                  useGoogleFonts: GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
              Text(
                widget.secondText ?? '',
                style: FlutterFlowTheme
                    .of(context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  fontSize:
                  14.0,
                  letterSpacing:
                  0.0,
                  fontWeight:
                  FontWeight
                      .w500,
                  useGoogleFonts: GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
