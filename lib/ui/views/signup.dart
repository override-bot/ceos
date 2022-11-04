// ignore_for_file: prefer_const_constructors

import 'package:ceos/core/services/authentication.dart';
import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/ui/shared/textfield.dart';
import 'package:ceos/ui/widgets/fullname.dart';
import 'package:ceos/ui/widgets/onbaording_one.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/color.dart';
import '../../utils/font_size.dart';

class RegisterView extends StatefulWidget {
  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ceoWhite,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          color: ceoWhite,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.5,
                      margin: const EdgeInsets.only(top: 0),
                      // child: Image.asset(),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/undraw_Access_account_re_8spm.png')))),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "Become\na CEO today! 💪",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: TextSize().h1(context),
                                color: ceoPurple),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 7),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "Please enter your valid data\nin order to create an account",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: TextSize().p(context),
                                color: ceoPurpleGrey),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: CustomTextField(
                                    hintText: "Email address",
                                    controller: _emailField,
                                    prefix: Icons.mail_outline_rounded,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: CustomTextField(
                                    obscureText: true,
                                    hintText: "Password",
                                    controller: _passwordField,
                                    prefix: Icons.lock_outline_rounded,
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 60,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: ceoPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              PopUp().popLoad(context);
                              await authService
                                  .register(_emailField.text.trim(),
                                      _passwordField.text.trim())
                                  .then((value) {
                                RouteController()
                                    .pushAndRemoveUntil(context, Fullname());
                              }).catchError((e) {
                                RouteController().pop(context);
                                PopUp().showError(e.message, context);
                                _passwordField.clear();
                              });
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: ceoWhite,
                                  fontSize: TextSize().h3(context)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }
}
