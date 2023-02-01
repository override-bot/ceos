import 'package:ceos/ui/widgets/chat_list_tile.dart';
import 'package:ceos/ui/widgets/empty_screen.dart';
import 'package:ceos/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../core/models/chat_model.dart';
import '../../core/services/authentication.dart';
import '../../core/viewmodels/chatviewmodel.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Chat> chats = [];
  @override
  Widget build(BuildContext context) {
    ChatViewModel _chatViewModel = ChatViewModel();
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: ceoWhite,
        child: StreamBuilder(
            stream: _chatViewModel.getChats(_auth.userId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return Empty();
                } else {
                  chats = snapshot.data!.docs
                      .map((doc) => Chat.fromMap(
                          doc.data() as Map<String, dynamic>, doc.id))
                      .toList();
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return ChatTile(
                          senderId: chats[index].userId,
                          receiverId: chats[index].receiverId,
                          messages: chats[index].messages,
                          chatId: chats[index].id,
                        );
                      });
                }
              } else {
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: ceoPink,
                )));
              }
            }));
  }
}
