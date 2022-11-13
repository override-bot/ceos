// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/core/viewmodels/product_viewmodel.dart';
import 'package:ceos/ui/shared/dropdown.dart';
import 'package:ceos/ui/shared/icon_circle.dart';
import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/ui/shared/text_icon_button.dart';
import 'package:ceos/ui/views/add_flash.dart';
import 'package:ceos/ui/views/add_product.dart';
import 'package:ceos/ui/widgets/flash_product_card.dart';
import 'package:ceos/ui/widgets/product_card.dart';
import 'package:ceos/utils/categories.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/flash_percent.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/font_size.dart';

class ProfileView extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ceoWhite,
          child: FutureBuilder<Ceo>(
            future: userViewModel.getCeoById(authService.userId),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 7),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                snapshot.data!.imageUrl.toString()),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 7, left: 7),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: TextSize().p(context),
                              color: ceoPurple),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 7, left: 7),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 0, bottom: 3),
                                  child: Text(
                                    '${snapshot.data?.username}💰',
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:
                                            TextSize().custom(11, context),
                                        color: ceoPurpleGrey),
                                  )),
                              Container(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (snapshot.data!.ceoScore! > 50) {
                                      PopUp().showScore(
                                          "You are a baller. You can keep balling by adding products and selling more.",
                                          context,
                                          "assets/undraw_dua_lipa_ixam copy.png",
                                          "Your ceo score is ${snapshot.data?.ceoScore}🎉");
                                    } else {
                                      PopUp().showScore(
                                          "You are a mechanic. You can become a baller by adding products and selling more.",
                                          context,
                                          "assets/undraw_stepping_up_g6oo copy.png",
                                          "Your ceo score is ${snapshot.data?.ceoScore}☹️");
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 0, bottom: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: greyOne!)),
                                    child: Text(
                                      '🧑🏿‍💼: ${snapshot.data?.ceoScore}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              TextSize().custom(11, context),
                                          color: ceoBlack),
                                    ),
                                  )),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 0, top: 5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TextIcon(
                                  icon: Icons.add_business,
                                  color: Colors.orange,
                                  text: "Add product",
                                  onPressed: () {
                                    RouteController()
                                        .push(context, AddProduct());
                                  }),
                              TextIcon(
                                icon: Icons.timer,
                                color: Colors.red,
                                onPressed: () {
                                  RouteController().push(context, AddFlash());
                                },
                                text: "Flash sale",
                              ),
                              TextIcon(
                                onPressed: () {
                                  PopUp().showError(
                                      "This feature is not yet available",
                                      context);
                                },
                                icon: Icons.delivery_dining,
                                color: Colors.green,
                                text: "Your orders",
                              ),
                              TextIcon(
                                icon: Icons.smart_display_rounded,
                                color: ceoPink,
                                text: "Create ad",
                              ),
                              TextIcon(
                                icon: Icons.settings,
                                color: ceoPurple,
                                text: "Settings",
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ceoPink,
                  ),
                );
              } else {
                print(snapshot.error);
                return Container();
              }
            }),
          )),
    );
  }
}
