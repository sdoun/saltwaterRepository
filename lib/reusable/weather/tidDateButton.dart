import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class Tiddatebutton extends StatefulWidget {
  const Tiddatebutton({super.key, this.ontap, required this.color, required this.text, required this.borderColor});
  final ontap;
  final Color color;
  final String text;
  final Color borderColor;

  @override
  State<Tiddatebutton> createState() => _TiddatebuttonState();
}

class _TiddatebuttonState extends State<Tiddatebutton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: FlutterFlowTheme.of(context).primaryBackground,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor:
      Colors.transparent,
      onTap: widget.ontap,
      child: Material(
        color: Colors.transparent,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              12.0),
        ),
        child: Container(
          width: 80.0,
          height: 31.0,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius:
            BorderRadius.circular(
                12.0),
            border: Border.all(
              color: widget.borderColor,
            ),
          ),
          alignment:
          const AlignmentDirectional(
              0.0, 0.0),
          child: Text(
            widget.text,
            style: FlutterFlowTheme.of(
                context)
                .bodyMedium
                .override(
              fontFamily:
              FlutterFlowTheme.of(
                  context)
                  .bodyMediumFamily,
              color: FlutterFlowTheme
                  .of(context)
                  .primaryText,
              letterSpacing: 0.0,
              fontWeight:
              FontWeight.w500,
              useGoogleFonts: GoogleFonts
                  .asMap()
                  .containsKey(
                  FlutterFlowTheme.of(
                      context)
                      .bodyMediumFamily),
            ),
          ),
        ),
      ),
    );
  }
}
