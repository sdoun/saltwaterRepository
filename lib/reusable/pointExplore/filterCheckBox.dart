import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class Filtercheckbox extends StatefulWidget {
  Filtercheckbox({super.key, required this.filterText, this.onChecked, required this.checkBoxValue});
  final String filterText;
  bool? checkBoxValue;
  final onChecked;

  @override
  State<Filtercheckbox> createState() => _FiltercheckboxState();
}

class _FiltercheckboxState extends State<Filtercheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
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
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5.0, 0.0, 8.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(4.0),
                      ),
                    ),
                    unselectedWidgetColor:
                    FlutterFlowTheme.of(context)
                        .secondaryText,
                  ),
                  child: Checkbox(
                    value: widget.checkBoxValue,
                    onChanged: widget.onChecked,
                    side: BorderSide(
                      width: 2,
                      color: FlutterFlowTheme.of(context)
                          .secondaryText,
                    ),
                    activeColor: FlutterFlowTheme.of(context)
                        .secondaryBackground,
                    checkColor: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Text(
                  widget.filterText,
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
            ],
          ),
        ),
      ),
    );
  }
}
