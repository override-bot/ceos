import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/ui/views/messageview.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/chatviewmodel.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/datetime.dart';

class ChatTile extends StatefulWidget {
  String? receiverId;
  String? senderId;
  List? messages;
  String? chatId;
  ChatTile(
      {Key? key, this.receiverId, this.senderId, this.messages, this.chatId})
      : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    ChatViewModel _chatViewModel = ChatViewModel();
    UserViewmodel _userViewmodel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    String? userId =
        widget.receiverId == _auth.userId ? widget.senderId : widget.receiverId;
    return FutureBuilder<Ceo>(
        future: _userViewmodel.getCeoById(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListTile(
              onTap: () {
                RouteController().push(
                    context,
                    MessagesView(
                      contractId: widget.chatId,
                      receiverId: userId,
                    ));
              },
              trailing: widget.messages!.isNotEmpty
                  ? Text(
                      '${DateTimeFormatter().displayTime(widget.messages?[widget.messages!.length - 1]['timeSent'])}',
                      style: TextStyle(
                        fontSize: TextSize().small(context),
                        color: ceoPurple,
                      ),
                    )
                  : null,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data?.imageUrl ?? ""),
              ),
              title: Text(
                '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
                style: TextStyle(
                    color: ceoPurple, fontSize: TextSize().p(context)),
              ),
              subtitle: widget.messages!.isNotEmpty
                  ? Text(widget.messages?[widget.messages!.length - 1]
                              ['senderId'] ==
                          _auth.userId
                      ? 'You:${widget.messages?[widget.messages!.length - 1]['message']}'
                      : widget.messages?[widget.messages!.length - 1]
                          ['message'])
                  : Text("tap to continue chat"),
            );
          } else {
            return ListTile();
          }
        });
  }
}
