import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/auth/firebase_auth/auth_util.dart';
import 'package:salt_water_beta_ver1/backend/schema/t_b_manager_chat_chat.dart';
import 'package:salt_water_beta_ver1/backend/schema/t_b_manager_chat_room_record.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:salt_water_beta_ver1/reusable/chat/chatBubble.dart';

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



class _ChatRoomState extends State<ChatRoom> {

  DocumentSnapshot? chatRoomSnapshot;
  final _textFormKey = GlobalKey<FormState>();

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
    return chatRoomRef.get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChats(DocumentSnapshot roomSnapshot){
    final chatCollection = roomSnapshot.reference.collection('room_chatCollection').orderBy('chat_createdAt', descending: false).snapshots();
    print('chat collection reference ${FirebaseFirestore.instance.doc(roomSnapshot.reference.toString()).collection('room_chatCollection')}');
    return chatCollection;
  }

  void createChat(String content){
    final chatRoomRef = FirebaseFirestore.instance.collection('/TB_managerChat_room').doc(currentUserReference!.id);
    TBManagerChatRecord.createDoc(TBManagerChatRecord.createId(chatRoomRef, null), currentUserReference!, content);
  }

  @override
  void initState() {
    super.initState();
    print('chatRoom get in');
    accessOrCreateChatRoom().then((DocumentSnapshot snapshot){
      setState(() {
        chatRoomSnapshot = snapshot;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    accessOrCreateChatRoom();
    final chatInputController = TextEditingController(text: '');
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
      body: Stack(
        children: [
          StreamBuilder(
              stream: fetchChats(chatRoomSnapshot!),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final chatList = snapshot.data!.docs.map((doc){
                    return TBManagerChatRecord.fromSnapshot(doc);
                  }).toList();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 80, left:  16, right: 16),
                    child: ListView.builder(
                      itemCount: chatList.length,
                        itemBuilder: (context, index){
                        final chat = chatList[index];
                          return Chatbubble(chatRecord: chat);
                        }
                    ),
                  );
                }
                if(snapshot.hasError){
                  return Center(
                    child: Text('HasError'),
                  );
                }
                else{
                  return Center(
                    child: Text('Its Not an snapshot error, but there is something wrong'),
                  );
                }
              }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 64,
              child: Form(
                key: _textFormKey,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return '내용을 입력해주세요.';
                    }
                    else{
                      return null;
                    }
                  },
                  controller: chatInputController,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () async{
                          if(_textFormKey.currentState!.validate()) {
                            createChat(chatInputController.text);
                            chatInputController.text = '';
                          }
                        },
                        child: Icon(
                            Icons.arrow_right_alt
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
