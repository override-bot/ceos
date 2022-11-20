import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';

class SubscriptionButton extends StatefulWidget {
  final String? uid;

  const SubscriptionButton({
    Key? key,
    this.uid,
  }) : super(key: key);

  @override
  State<SubscriptionButton> createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends State<SubscriptionButton> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: userViewModel.streamCeoById(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;
            bool subscriptionStatus =
                data['subscribers'].contains(authService.userId);
            return IconButton(
                onPressed: () {
                  if (subscriptionStatus == true) {
                    userViewModel.unsubscribe(authService.userId, widget.uid);
                    PopUp().showSuccess(
                        "unsubscribed successfully. You will no longer see latest products by this ceo in your home screen",
                        context);
                  } else {
                    PopUp().showSuccess(
                        "Subscription successful. You will see latest products by this ceo in your home screen",
                        context);
                    userViewModel.subscribe(authService.userId, widget.uid);
                  }
                },
                icon: Icon(
                  subscriptionStatus == true
                      ? Icons.notifications_active
                      : Icons.notifications,
                  color: subscriptionStatus == true ? ceoPink : ceoBlack,
                ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return Container();
          }
        });
  }
}
