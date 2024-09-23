import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

class socialButton extends StatefulWidget {
  const socialButton({super.key, required this.onPressed, required this.text, required this.backgroundColor, required this.icon, required this.textColor});

  final onPressed;
  final String text;
  final Color backgroundColor;
  final Widget? icon;
  final Color textColor;

  @override
  State<socialButton> createState() => _socialButtonState();
}

class _socialButtonState extends State<socialButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional
          .fromSTEB(
          0.0,
          0.0,
          0.0,
          16.0),
      child: FFButtonWidget(
        onPressed: widget.onPressed,
        text: widget.text,
        icon: widget.icon,
        options:
        FFButtonOptions(
          width: 216.0,
          height: 44.0,
          padding:
          const EdgeInsetsDirectional
              .fromSTEB(
              0.0,
              0.0,
              0.0,
              0.0),
          iconPadding:
          const EdgeInsetsDirectional
              .fromSTEB(
              0.0,
              0.0,
              0.0,
              0.0),
          color: widget.backgroundColor,
          textStyle:
          FlutterFlowTheme.of(
              context)
              .bodyMedium
              .override(
            fontFamily:
            FlutterFlowTheme.of(context).bodyMediumFamily,
            fontSize:
            16.0,
            letterSpacing:
            0.0,
            fontWeight:
            FontWeight.bold,
            useGoogleFonts:
            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
            color: widget.textColor,
          ),
          elevation: 2.0,
          borderSide:
          BorderSide(
            color: widget.backgroundColor,
            width: 2.0,
          ),
          borderRadius:
          BorderRadius
              .circular(
              12.0),
          hoverColor:
          FlutterFlowTheme.of(
              context)
              .primaryBackground,
        ),
      ),
    );
  }
}
