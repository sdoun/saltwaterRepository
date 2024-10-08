import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'point_category_model.dart';
export 'point_category_model.dart';

import 'package:salt_water_beta_ver1/reusable/pointExplore/pointCategory.dart';

class PointCategoryWidget extends StatefulWidget {
  const PointCategoryWidget({super.key});

  @override
  State<PointCategoryWidget> createState() => _PointCategoryWidgetState();
}

class _PointCategoryWidgetState extends State<PointCategoryWidget> {
  late PointCategoryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PointCategoryModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 364.0,
      height: 380.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(18.0, 21.0, 18.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '포인트구분',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: Colors.black,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).bodyMediumFamily),
                  ),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pointcategory(
                    pointType: '방파제, 선착장',
                    onTap: () async {
                      context.pushNamed('exploreMapSW');

                      Navigator.pop(context, '방파제, 선착장');
                    },
                  ),
                  Pointcategory(
                    pointType: '낚시공원',
                    onTap: () async {
                      context.pushNamed('fishingParkMap');

                      Navigator.pop(context);
                      },
                  ),
                  Pointcategory(
                      pointType: '해변, 갯바위',
                      onTap: () async {
                        context.pushNamed('exploreMapOcean');
                      },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pointcategory(
                      pointType: '낚시펜션, 민박',
                      onTap: () async {
                        context.pushNamed('exploreMapFishingPension');
                      },
                  ),
                  Pointcategory(
                    pointType: '좌대, 해상펜션',
                    onTap: () async {
                      context.pushNamed('exploreMap_stand');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
