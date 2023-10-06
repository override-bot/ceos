import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/removeat.dart';

class Username extends StatefulWidget {
  final String? userId;
  const Username({Key? key, this.userId}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewmodel>(context);
    return FutureBuilder<Ceo>(
        future: userViewModel.getCeoById(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              'by ${removeAtSymbol(snapshot.data?.username ?? "")}',
              style: TextStyle(
                  fontSize: TextSize().p(context),
                  color: ceoPurpleGrey,
                  fontWeight: FontWeight.w500),
            );
          } else {
            return Text("");
          }
        });
  }
}
