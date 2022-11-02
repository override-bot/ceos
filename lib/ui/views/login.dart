import 'package:ceos/core/services/authentication.dart';
import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/ui/shared/textfield.dart';
import 'package:ceos/ui/widgets/onbaording_one.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/color.dart';
import '../../utils/font_size.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
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
        color: ceoWhite,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              margin: const EdgeInsets.only(top: 0),
              // child: Image.asset(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/undraw_Login_re_4vu2.png')))),
          Container(
            margin: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "Welcome back\nOur able CEO 🙌🏻",
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
                    "Please enter your valid data\nin order to login to your account",
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
                          .login(_emailField.text.trim(),
                              _passwordField.text.trim())
                          .then((value) {
                        RouteController()
                            .pushAndRemoveUntil(context, OnboardingOne());
                      }).catchError((e) {
                        RouteController().pop(context);
                        PopUp().showError(e.message, context);
                        _passwordField.clear();
                      });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: ceoWhite, fontSize: TextSize().h3(context)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
