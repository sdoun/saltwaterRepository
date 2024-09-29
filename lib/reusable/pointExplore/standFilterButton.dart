import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/backend/backend.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../pages/point_explore_sum/point_explore_stand/stand_1st_filter/stand1st_filter_widget.dart';

class Standfilterbutton extends StatefulWidget {
  const Standfilterbutton({super.key, required this.iniitalText, this.onTap, this.filterValue});

  final String iniitalText;
  final onTap;
  final filterValue;

  @override
  State<Standfilterbutton> createState() => _StandfilterbuttonState();
}

class _StandfilterbuttonState extends State<Standfilterbutton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(8.0),
        child: Container(
          height: 32.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context)
                .primaryBackground,
            borderRadius:
            BorderRadius.circular(8.0),
            border: Border.all(
              color: (widget.filterValue !=
                  null &&
                  (widget.filterValue)!
                      .isNotEmpty) ==
                  true
                  ? FlutterFlowTheme.of(context)
                  .primary
                  : const Color(0xff949494),
              width: 2,
            ),
          ),
          alignment:
          const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional
                .fromSTEB(4.0, 0.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    final firstFilter = widget.filterValue
                        ?.toList() ??
                        [];

                    return Row(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: List.generate(
                          firstFilter.length,
                              (firstFilterIndex) {
                            final firstFilterItem =
                            firstFilter[
                            firstFilterIndex];
                            return Text(
                              firstFilterItem ==
                                  widget.filterValue
                                      ?.last
                                  ? firstFilterItem
                                  : '$firstFilterItem, ',
                              style: FlutterFlowTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme.of(
                                    context)
                                    .primaryText,
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
                            );
                          }),
                    );
                  },
                ),
                if ((widget.filterValue !=
                    null &&
                    (widget.filterValue)!
                        .isNotEmpty) ==
                    false)
                  Text(
                    (widget.filterValue !=
                        null &&
                        (widget.filterValue)!
                            .isNotEmpty) ==
                        true
                        ? ''
                        : widget.iniitalText,
                    style: FlutterFlowTheme
                        .of(context)
                        .bodyMedium
                        .override(
                      fontFamily:
                      'PretendardSeries',
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
                const Align(
                  alignment:
                  AlignmentDirectional(
                      1.0, 0.0),
                  child: Icon(
                    Icons
                        .keyboard_arrow_down_outlined,
                    color: Colors.black,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
