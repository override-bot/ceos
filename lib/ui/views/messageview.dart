import 'package:ceos/core/services/authentication.dart';
import 'package:ceos/core/viewmodels/user_viewmodel.dart';
import 'package:ceos/ui/widgets/chat_avatar.dart';
import 'package:ceos/ui/widgets/chatname.dart';
import 'package:ceos/utils/color.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/chat_model.dart';
import '../../core/models/message_model.dart';
import '../../core/viewmodels/chatviewmodel.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../utils/datetime.dart';

class MessagesView extends StatefulWidget {
  final String? contractId;
  final String? receiverId;
  MessagesView({required this.contractId, this.receiverId});
  MessagesViewState createState() => MessagesViewState();
}

class MessagesViewState extends State<MessagesView> {
  List<Message> messages = [];
  TextEditingController textEditingController = TextEditingController();
  Chat? chat;
  bool isText = false;
  @override
  Widget build(BuildContext context) {
    ChatViewModel _chatViewModel = ChatViewModel();
    UserViewmodel _userViewmodel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return StreamBuilder(
        stream: _chatViewModel.getChatById(widget.contractId, _auth.userId),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            chat = Chat.fromMap(snapshot.data?.data() as Map<String, dynamic>,
                widget.contractId);

            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: ceoPurple,
                          ))
                    ],
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ChatAvatar(
                          userId: widget.receiverId,
                        ),
                        Container(
                          width: 10,
                        ),
                        ChatName(
                          userId: widget.receiverId,
                        )
                      ],
                    )),
                body: Stack(children: [
                  chat!.messages!.length < 1 && chat!.messages != null
                      ? Center(
                          child: Text("Your chat begins here"),
                        )
                      : Container(
                          color: greyOne,
                          // height: MediaQuery.of(context).size.height / 1.2,
                          padding: EdgeInsets.only(bottom: 75),
                          child: ListView.builder(
                              reverse: true,
                              // shrinkWrap: true,
                              itemCount: chat!.messages!.length,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  Container(
                                    height: 5,
                                  ),
                                  BubbleSpecialOne(
                                      sent: chat!.messages!.reversed.toList()[index]["senderId"] == _auth.userId
                                          ? true
                                          : false,
                                      isSender: chat!.messages!.reversed.toList()[index]
                                                  ["senderId"] ==
                                              _auth.userId
                                          ? true
                                          : false,
                                      color: chat!.messages!.reversed.toList()[index]
                                                  ["senderId"] ==
                                              _auth.userId
                                          ? ceoPurple
                                          : Colors.white,
                                      textStyle: TextStyle(
                                          color: chat!.messages!.reversed.toList()[index]
                                                      ["senderId"] ==
                                                  _auth.userId
                                              ? Colors.white
                                              : Colors.black),
                                      text: chat!.messages!.reversed.toList()[index]
                                          ["message"]),
                                  Align(
                                    alignment: chat!.messages!.reversed
                                                .toList()[index]["senderId"] ==
                                            _auth.userId
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 7, right: 7, bottom: 5),
                                      child: Text(
                                        DateTimeFormatter().displayTime(chat!
                                            .messages!.reversed
                                            .toList()[index]["timeSent"]),
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 12,
                                  )
                                ]);
                              })),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              margin:
                                  EdgeInsets.only(left: 15, bottom: 25, top: 5),
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                controller: textEditingController,
                                autocorrect: true,
                                onChanged: (value) {
                                  if (value.length < 1) {
                                    setState(() {
                                      isText = false;
                                    });
                                  } else {
                                    setState(() {
                                      isText = true;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "send a message",
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ceoPurple)),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              )),
                          IconButton(
                            onPressed: isText == true
                                ? () async {
                                    var text = textEditingController.text;
                                    if (!text.isEmpty) {
                                      _chatViewModel.sendMessage(
                                          Message(
                                              receiverId: widget.receiverId,
                                              senderId: _auth.userId,
                                              timeSent: DateTime.now(),
                                              contentType: 'text',
                                              message:
                                                  textEditingController.text),
                                          widget.contractId,
                                          _auth.userId,
                                          widget.receiverId);
                                      textEditingController.clear();
                                    } else {
                                      print("hehe");
                                    }
                                    print(chat!.messages);
                                  }
                                : null,
                            icon: Icon(
                              Icons.send,
                              color: ceoPurple,
                            ),
                            iconSize: 20.0,
                          )
                        ],
                      ),
                    ),
                  )
                ]));
          } else
            return Container();
        });
  }
}
