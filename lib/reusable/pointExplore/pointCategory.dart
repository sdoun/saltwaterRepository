import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class Pointcategory extends StatefulWidget {
  const Pointcategory({super.key, this.onTap, required this.pointType});

  final onTap;
  final String pointType;

  @override
  State<Pointcategory> createState() => _PointcategoryState();
}

class _PointcategoryState extends State<Pointcategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent, 
        highlightColor: Colors.transparent,
        onTap: widget.onTap,
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            border: Border.all(
              color: const Color(0xFF545454),
              width: 1.0,
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  8.0, 0.0, 8.0, 0.0),
              child: Text(
                widget.pointType,
                style: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                  fontFamily: 'PretendartSeries',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: GoogleFonts
                      .asMap()
                      .containsKey(
                      'PretendardSeries'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
