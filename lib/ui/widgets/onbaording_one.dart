// ignore_for_file: prefer_const_constructors

import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/ui/views/app_index.dart';
import 'package:ceos/ui/widgets/fullname.dart';
import 'package:ceos/ui/widgets/onboarding_two.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/cart_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';

class OnboardingOne extends StatefulWidget {
  @override
  OnboardingOneState createState() => OnboardingOneState();
}

class OnboardingOneState extends State<OnboardingOne> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    CartViewmodel _cartViewmodel = Provider.of<CartViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ceoWhite,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ceoWhite,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.only(top: 0),
              // child: Image.asset(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          'assets/undraw_Online_shopping_re_k1sv.png')))),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "A shop\nin your pocket",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h(context),
                        color: ceoPurple),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 7),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "Welcome to ceos\nWith ceos we can save your time 🥳",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize().h3(context),
                        color: ceoPurpleGrey),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  child: MaterialButton(
                    onPressed: () async {
                      await _cartViewmodel.loadCarts();
                      authService.getAuthState();
                      print(authService.userId);
                      if (authService.authState == true) {
                        PopUp().popLoad(context);
                        bool result =
                            await userViewModel.checkIfUser(authService.userId);
                        if (result == true) {
                          RouteController()
                              .pushAndRemoveUntil(context, AppIndex());
                        } else {
                          RouteController().push(context, Fullname());
                        }
                      } else {
                        RouteController().push(context, OnboardingTwo());
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ceoWhite,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ceoPink, borderRadius: BorderRadius.circular(45)),
                ),
              ))
        ]),
      ),
    );
  }
}
