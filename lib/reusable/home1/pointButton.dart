import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class pointButton extends StatefulWidget {
  const pointButton({super.key, this.ontap, required this.text, this.image});
  final ontap;
  final String text;
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
              AutoSizeText(
                widget.text,
                style: FlutterFlowTheme
                    .of(context)
                    .bodyMedium
                    .override(
                  fontFamily:
                  'PretendardSeries',
                  fontSize:
                  12.0,
                  letterSpacing:
                  0.0,
                  fontWeight:
                  FontWeight
                      .w600,
                  useGoogleFonts: GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
