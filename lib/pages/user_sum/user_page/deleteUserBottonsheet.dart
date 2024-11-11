import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/filterBackground.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/pointCategory.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';

class Deleteuserbottonsheet extends StatelessWidget {
  const Deleteuserbottonsheet({super.key, this.clickYes, this.clickNo});
  final clickYes;
  final clickNo;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          width: 351.0,
          height: 240.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18.0, 21.0, 18.0, 0.0),
            child: Filterbackground(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '회원탈퇴 하시겠습니까?',
                    style: FlutterFlowTheme.of(context)
                        .titleLarge
                        .override(
                      fontFamily: 'PretendardSeries',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap()
                          .containsKey(
                          'PretendardSeries'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pointcategory(
                        pointType: '  예  ',
                        onTap: clickYes,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Pointcategory(
                        pointType: ' 아니오 ',
                        onTap: (){
                          context.pop();
                        },
                      )
                    ],
                  ),
                  Text(
                    '회원탈퇴 시 작성하신 글과 활동 내역은 삭제됩니다. \n삭제된 정보는 다시 복구 할 수 없습니다.',
                    style: FlutterFlowTheme.of(context)
                        .titleSmall
                        .override(
                      fontFamily: 'PretendardSeries',
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap()
                          .containsKey(
                          'PretendardSeries'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
