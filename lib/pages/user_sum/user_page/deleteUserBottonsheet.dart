import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/filterBackground.dart';
import 'package:salt_water_beta_ver1/reusable/pointExplore/pointCategory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';

class Deleteuserbottonsheet extends StatelessWidget {
  const Deleteuserbottonsheet({super.key, this.clickYes, this.clickNo});
  final clickYes;
  final clickNo;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pointcategory(
                        pointType: '  예  ',
                        onTap: clickYes,
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
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Column(
                    children: [
                      Text(
                        '회원탈퇴 시 작성하신 글과 활동 내역은 삭제됩니다. \n회원탈퇴시 계정도 함께 삭제됩니다.',
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
                      ),
                      RichText(
                          text: TextSpan(
                            text: '자세히 보기',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'PretendardSeries',
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap()
                                  .containsKey(
                                  'PretendardSeries'),
                              decoration: TextDecoration.underline
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                              final Uri url = Uri.parse('https://saltwatercustomer.modoo.at/?link=17m8f8lj');
                              _launchUrl(url);
                              }
                          ),

                      )
                    ],
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
