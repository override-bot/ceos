import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/user_viewmodel.dart';

class ChatName extends StatefulWidget {
  final String? userId;
  const ChatName({Key? key, this.userId}) : super(key: key);

  @override
  State<ChatName> createState() => _ChatNameState();
}

class _ChatNameState extends State<ChatName> {
  @override
  Widget build(BuildContext context) {
    UserViewmodel _userViewmodel = Provider.of<UserViewmodel>(context);
    return FutureBuilder<Ceo>(
        future: _userViewmodel.getCeoById(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
              style: TextStyle(
                color: ceoPurple,
                fontSize: (15 / 720) * MediaQuery.of(context).size.height,
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
