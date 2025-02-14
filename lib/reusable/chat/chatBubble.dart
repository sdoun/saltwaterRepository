import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/backend/schema/t_b_manager_chat_chat.dart';

import '../../auth/firebase_auth/auth_util.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class Chatbubble extends StatelessWidget {
  const Chatbubble({super.key, required this.chatRecord});

  final TBManagerChatRecord chatRecord;

  @override
  Widget build(BuildContext context) {
    final bool isMyMessage = (chatRecord.sendBy == currentUserReference);
    final alignX = isMyMessage ? -1.0 : 1.0;
    final alignment = isMyMessage ?  Alignment.centerRight : Alignment.centerLeft;
    final bubbleType = isMyMessage ? BubbleType.sendBubble : BubbleType.receiverBubble;
    return Row(
      mainAxisAlignment: isMyMessage? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Align(
          alignment: isMyMessage ?  Alignment.centerRight : Alignment.centerLeft,
          child: ChatBubble(
            backGroundColor: isMyMessage ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryBackground,
            clipper: ChatBubbleClipper2(type: bubbleType),
            child: Text(
              chatRecord.content ?? '',
              style: FlutterFlowTheme.of(context)
                  .bodyMedium.override(
                  fontFamily:
                  'PretendardSeries',
                  color: isMyMessage ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primaryText,
                  fontSize: 13.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w400,
                  useGoogleFonts: GoogleFonts
                      .asMap()
                      .containsKey(
                  'PretendardSeries'),
              ),
            )
          ),
        ),
      ],
    );
  }
}
