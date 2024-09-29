import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles({super.key, required this.message, required this.isMine});
  final String message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMine? MainAxisAlignment.end
      : MainAxisAlignment.start,
      children: [
        Container(
          child: Text(
            message,
          ),
        ),
        ChatBubble(
          backGroundColor: isMine? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
          child: Text(message),
        )
      ],
    );
  }
}
