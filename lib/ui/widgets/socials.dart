// ignore_for_file: prefer_const_constructors

import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/ui/views/app_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/color.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/textfield.dart';

class Socials extends StatefulWidget {
  @override
  SocialsState createState() => SocialsState();
}

class SocialsState extends State<Socials> {
  bool? isPhoneNumber;
  TextEditingController _phoneField = TextEditingController();
  TextEditingController _walink = TextEditingController();
  TextEditingController _iglink = TextEditingController();
  TextEditingController _twlink = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ceoWhite,
          leading: IconButton(
            onPressed: () {
              RouteController().pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ceoPurple,
            ),
          ),
        ),
        body: Container(
            //  alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ceoWhite,
            child: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 15),
                            child: Text(
                              "Complete registration 3/3 🥳",
                              style: TextStyle(
                                  color: ceoPurple,
                                  fontSize: TextSize().p(context)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Add contact details",
                              style: TextStyle(
                                  color: ceoPurple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: TextSize().h1(context)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Add phone number and social media links to enable buyers contact you",
                              style: TextStyle(
                                  color: ceoPurpleGrey,
                                  fontSize: TextSize().h3(context)),
                            ),
                          ),
                          Center(
                              child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: CustomTextField(
                                    onChanged: (String text) {
                                      if (text.length == 11) {
                                        setState(() {
                                          isPhoneNumber = true;
                                        });
                                      } else {
                                        setState(() {
                                          isPhoneNumber = false;
                                        });
                                      }
                                    },
                                    hintText: "Phone number",
                                    errorText: isPhoneNumber == false
                                        ? "Phone number must be 11 characters"
                                        : null,
                                    controller: _phoneField,
                                    // prefix: Icons.person_outline_rounded,
                                  ))),
                          Center(
                              child: Container(
                                  child: CustomTextField(
                            hintText: "Twitter link (optional)",

                            controller: _twlink,
                            // prefix: Icons.person_outline_rounded,
                          ))),
                          Center(
                              child: Container(
                                  child: CustomTextField(
                            hintText: "Whatsapp link (optional)",

                            controller: _walink,
                            // prefix: Icons.person_outline_rounded,
                          ))),
                          Center(
                              child: Container(
                                  child: CustomTextField(
                            hintText: "Instagram link (optional)",

                            controller: _iglink,
                            // prefix: Icons.person_outline_rounded,
                          ))),
                          Expanded(child: Container()),
                          Center(
                              child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 60,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: ceoPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MaterialButton(
                              onPressed: isPhoneNumber == true
                                  ? () async {
                                      PopUp().popLoad(context);
                                      userViewModel
                                          .setPhoneNumber(_phoneField.text);
                                      userViewModel
                                          .setInstagramLink(_iglink.text);
                                      userViewModel
                                          .setTwitterLink(_twlink.text);
                                      userViewModel
                                          .setWhatsappLink(_walink.text);
                                      userViewModel
                                          .addUser(
                                              Ceo(
                                                  subscribers: [],
                                                  ceoScore: 0,
                                                  whatsappLink: userViewModel
                                                      .whatsappLink,
                                                  twitterLink:
                                                      userViewModel.twitterLink,
                                                  instagramLink: userViewModel
                                                      .instagramLink,
                                                  phoneNumber:
                                                      userViewModel.phoneNumber,
                                                  firstname:
                                                      userViewModel.firstname,
                                                  lastname:
                                                      userViewModel.lastname,
                                                  imageUrl:
                                                      userViewModel.imageUrl,
                                                  username:
                                                      "@${userViewModel.firstname?.toLowerCase()}"),
                                              authService.userId)
                                          .then((value) {
                                        RouteController().pushAndRemoveUntil(
                                            context, AppIndex());
                                      });
                                      print(userViewModel.phoneNumber);
                                    }
                                  : null,
                              child: Text(
                                "Complete registration",
                                style: TextStyle(
                                    color: ceoWhite,
                                    fontSize: TextSize().h3(context)),
                              ),
                            ),
                          )),
                          Container(
                            height: 20,
                          )
                        ])))));
  }
}
