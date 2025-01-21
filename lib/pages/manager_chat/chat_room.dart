import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/auth/firebase_auth/auth_util.dart';
import 'package:salt_water_beta_ver1/backend/schema/t_b_manager_chat_chat.dart';
import 'package:salt_water_beta_ver1/backend/schema/t_b_manager_chat_room_record.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../../components/chatFAB.dart';
import '../../components/custom_navbar_widget.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_model.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

Future<DocumentSnapshot> accessOrCreateChatRoom() async{
  final chatRoomRef = FirebaseFirestore.instance.collection('/TB_managerChat_room').doc(currentUserReference!.id);
  try{
    final chatRoomDoc = await chatRoomRef.get();
    if(chatRoomDoc.data() == null || chatRoomDoc.data()!.isEmpty){
      await chatRoomRef.set({
        "room_chatUser" : currentUserReference
      });
    }
    else{
      print('room exist');
    }
  }catch(e){
    print('Error on Create Or Access ChatRoom $e');
  }
  TBManagerChatRecord.createDoc(TBManagerChatRecord.createId(chatRoomRef, 'Test'), currentUserReference!, 'Test');
  return await chatRoomRef.get();
}

@override
void initState() async{
  print('chatRoom get in');
  await accessOrCreateChatRoom();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    accessOrCreateChatRoom();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: const AlignmentDirectional(-1.0, -3.7),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                24.0, 0.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
          ),
        ),
        title: Align(
          alignment: const AlignmentDirectional(0.0, -1.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                0.0, 0.0, 0.0, 0.0),
            child: Text(
              '1대1 문의하기',
              style: FlutterFlowTheme
                  .of(context)
                  .bodyMedium
                  .override(
                fontFamily: 'PretendardSeries',
                fontSize: 20.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w800,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey('PretendardSeries'),
              ),
            ),
          ),
        ),
        actions: const [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.transparent,
              size: 30.0,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: accessOrCreateChatRoom(),
          builder: (context, snapshot){

            if(snapshot.hasData){
              final data = snapshot.data!['room_chatUser'];
              final docSnapshot = snapshot.data;
              final roomRecord = TBManagerChatRoomRecord.fromSnapshot(docSnapshot!);
              return Text(
                  roomRecord.chatUser.toString()
              );
            }
            else{
              return Text('snapshot no data');
            }
          }
      ),
    );
  }
}
