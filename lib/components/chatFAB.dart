import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:salt_water_beta_ver1/backend/api_requests/api_calls.dart';
import 'package:salt_water_beta_ver1/index.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class ChatFab extends StatefulWidget {
  const ChatFab({super.key});

  @override
  State<ChatFab> createState() => _ChatFabState();
}

class _ChatFabState extends State<ChatFab> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: (){
          try{
            context.pushNamed('managerChatRoom');
          }catch(e){
            print('push error :$e');
          }
        },
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
        child: Image.asset(
            'assets/images/1대1문의.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
