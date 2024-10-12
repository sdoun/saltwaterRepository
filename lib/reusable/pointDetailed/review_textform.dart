import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class ReviewTextform extends StatefulWidget {
  const ReviewTextform({super.key, this.controller, this.focusNode, this.validator, this.hintText, this.initialText});
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final validator;
  final String? hintText;
  final String? initialText;

  @override
  State<ReviewTextform> createState() => _ReviewTextformState();
}

class _ReviewTextformState extends State<ReviewTextform> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: true,
      obscureText: false,
      initialValue: widget.initialText,
      decoration: InputDecoration(
        labelStyle: FlutterFlowTheme.of(context)
            .labelMedium
            .override(
          fontFamily:
          FlutterFlowTheme.of(context).labelMediumFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          useGoogleFonts: GoogleFonts.asMap().containsKey(
              FlutterFlowTheme.of(context).labelMediumFamily),
        ),
        hintText: widget.hintText,
        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
          fontFamily:
          'PretendardSeries',
          color: FlutterFlowTheme.of(context)
              .primaryText,
          fontSize: 14.0,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w400,
          useGoogleFonts: GoogleFonts.asMap().containsKey(
              'PretendardSeries'),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).secondaryText,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
        fontFamily:
        'PretendardSeries',
        color: FlutterFlowTheme.of(context)
            .primaryText,
        fontSize: 14.0,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w400,
        useGoogleFonts: GoogleFonts.asMap().containsKey(
            'PretendardSeries'),
      ),
      validator: widget.validator,
    );
  }
}
