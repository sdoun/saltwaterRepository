import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_theme.dart';

import '../pointExplore/pointCategory.dart';

class Appoffbottomsheet extends StatelessWidget {
  const Appoffbottomsheet({super.key, this.onExit});
  final onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: FlutterFlowTheme.of(context).primaryBackground
      ),
      height: 240,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(18.0, 36.0, 18.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '앱을 종료하시겠습니까?',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily:
                'PretendardSeries',
                color: FlutterFlowTheme.of(context)
                    .primaryText,
                fontSize: 20.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                useGoogleFonts: GoogleFonts.asMap().containsKey(
                    'PretendardSeries'),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pointcategory(
                  pointType: '  예  ',
                  onTap: (){
                    SystemNavigator.pop();
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                Pointcategory(
                  pointType: ' 아니오 ',
                  onTap: (){
                    context.pop();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
