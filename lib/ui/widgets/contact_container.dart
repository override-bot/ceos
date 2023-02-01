import 'package:ceos/core/models/chat_model.dart';
import 'package:ceos/core/models/message_model.dart';
import 'package:ceos/core/viewmodels/chatviewmodel.dart';
import 'package:ceos/core/viewmodels/user_viewmodel.dart';
import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/ui/views/messageview.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/user_model.dart';
import '../../core/services/authentication.dart';

class ContactC extends StatefulWidget {
  String? uid;
  ContactC({Key? key, this.uid}) : super(key: key);

  @override
  State<ContactC> createState() => _ContactCState();
}

class _ContactCState extends State<ContactC> {
  @override
  Widget build(BuildContext context) {
    UserViewmodel _userViewmodel = Provider.of<UserViewmodel>(context);
    ChatViewModel _chat = ChatViewModel();
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    return FutureBuilder<Ceo>(
        future: _userViewmodel.getCeoById(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(
                      "Contact ${snapshot.data?.firstname} via:",
                      style: TextStyle(
                          color: ceoPurple, fontSize: TextSize().p(context)),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: snapshot.data!.phoneNumber,
                      );
                      await launchUrl(launchUri);
                    },
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ceoPurple,
                    ),
                    leading: Icon(
                      Icons.call,
                      size: TextSize().h1(context),
                      color: ceoPurple,
                    ),
                    title: Text(
                      "Call(recommended)",
                      style: TextStyle(
                          color: ceoPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context)),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      PopUp().popLoad(context);
                      var result = await _chat.checkIfChatted(
                          _auth.userId! + widget.uid!, _auth.userId);
                      RouteController().pop(context);
                      if (result == true) {
                        RouteController().push(
                            context,
                            MessagesView(
                                receiverId: widget.uid,
                                contractId: _auth.userId! + widget.uid!));
                      } else {
                        await _chat.beginChat(
                            Chat(
                                messages: [],
                                receiverId: widget.uid,
                                userId: _auth.userId),
                            _auth.userId,
                            widget.uid);
                        RouteController().push(
                            context,
                            MessagesView(
                                receiverId: widget.uid,
                                contractId: _auth.userId! + widget.uid!));
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ceoPurple,
                    ),
                    leading: Icon(
                      Icons.chat_bubble,
                      size: TextSize().h1(context),
                      color: ceoPink,
                    ),
                    title: Text(
                      "Chat(convenient)",
                      style: TextStyle(
                          color: ceoPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context)),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      if (snapshot.data!.twitterLink != null) {
                        Uri url = Uri.parse(snapshot.data!.twitterLink ?? "");
                        launchUrl(url);
                      } else {
                        PopUp().showError("No twitter account found", context);
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ceoPurple,
                    ),
                    leading: Container(
                        height: 35,
                        width: 35,
                        child: Image(image: AssetImage('assets/twtlg.png'))),
                    title: Text(
                      "Twitter",
                      style: TextStyle(
                          color: ceoPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context)),
                    ),
                  ),
                  Container(
                    height: 4,
                  ),
                  ListTile(
                    onTap: () {
                      if (snapshot.data!.instagramLink != null) {
                        Uri url = Uri.parse(snapshot.data!.instagramLink ?? "");
                        launchUrl(url);
                      } else {
                        PopUp()
                            .showError("No instagram account found", context);
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ceoPurple,
                    ),
                    leading: Container(
                        height: 35,
                        width: 35,
                        child: Image(image: AssetImage('assets/iglg.jpeg'))),
                    title: Text(
                      "Instagram",
                      style: TextStyle(
                          color: ceoPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context)),
                    ),
                  ),
                  Container(
                    height: 4,
                  ),
                  ListTile(
                    onTap: () {
                      if (snapshot.data!.whatsappLink != null) {
                        Uri url = Uri.parse(snapshot.data!.whatsappLink ?? "");
                        launchUrl(url);
                      } else {
                        PopUp().showError("No whatsapp account found", context);
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ceoPurple,
                    ),
                    leading: Container(
                        height: 35,
                        width: 35,
                        child: Image(image: AssetImage('assets/walg.png'))),
                    title: Text(
                      "Whatsapp",
                      style: TextStyle(
                          color: ceoPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: TextSize().small(context)),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Center(
                child: CircularProgressIndicator(
                  color: ceoPink,
                ),
              ),
            );
          }
        });
  }
}
