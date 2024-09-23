import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '../../app_state.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../pages/point_explore_sum/point_category/point_category_widget.dart';

class Fishbutton extends StatefulWidget {
  const Fishbutton({super.key, required this.text, this.image});

  final String text;
  final Widget? image;

  @override
  State<Fishbutton> createState() => _FishbuttonState();
}

class _FishbuttonState extends State<Fishbutton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor:
      Colors.transparent,
      onTap: () async {
        FFAppState().fishes = [];
        safeSetState(() {});
        FFAppState().addToFishes(widget.text);
        safeSetState(() {});
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor:
          Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return WebViewAware(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(
                        context)
                        .unfocus(),
                child: Padding(
                  padding: MediaQuery
                      .viewInsetsOf(
                      context),
                  child:
                  const PointCategoryWidget(),
                ),
              ),
            );
          },
        ).then((value) =>
            safeSetState(() {}));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,
        children: [
          Container(
            width: MediaQuery.sizeOf(
                context)
                .width *
                0.16,
            height: 72.0,
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
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(
                  8.0),
              child: widget.image
            ),
          ),
          Text(
            widget.text,
            style: FlutterFlowTheme.of(
                context)
                .bodyMedium
                .override(
              fontFamily:
              'PretendardSeries',
              fontSize: 14.0,
              letterSpacing: 0.0,
              fontWeight:
              FontWeight.w500,
              useGoogleFonts:
              GoogleFonts
                  .asMap()
                  .containsKey(
                  'PretendardSeries'),
            ),
          ),
        ],
      ),
    );
  }
}
