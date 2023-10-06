// ignore_for_file: prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:ceos/ui/views/categories.dart';
import 'package:ceos/ui/views/chatview.dart';
import 'package:ceos/ui/views/home_view.dart';
import 'package:ceos/ui/views/profile_view.dart';
import 'package:ceos/ui/widgets/avatar.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../utils/router.dart';
import '../widgets/cart_icon.dart';
import 'super_cart_view.dart';

class AppIndex extends StatefulWidget {
  @override
  AppIndexState createState() => AppIndexState();
}

class AppIndexState extends State<AppIndex> {
  int currentIndex = 0;
  List children = [Home(), CategoriesView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CartIcon(
            onPressed: () {
              RouteController().push(context, SuperCartScreen());
            },
          )
        ],
        title: currentIndex == 1
            ? Text(
                'Categories',
                style: TextStyle(
                    color: ceoPurple, fontSize: TextSize().h2(context)),
              )
            : null,
        leading: currentIndex < 2 ? Avatar() : null,
        backgroundColor: ceoWhite,
        elevation: 0.0,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ceoWhite,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: ceoWhite,
          selectedItemColor: ceoPink,
          unselectedItemColor: ceoPurple,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 5.0,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.home_outlined,
                  size: 20,
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.category_outlined,
                  size: 20,
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.person_outline_outlined,
                  size: 20,
                ))
          ],
          onTap: onTabTapped,
        ),
      ),
      body: children[currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
