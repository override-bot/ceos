// ignore_for_file: prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:ceos/ui/views/home_view.dart';
import 'package:ceos/ui/views/profile_view.dart';
import 'package:ceos/ui/widgets/avatar.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';

class AppIndex extends StatefulWidget {
  @override
  AppIndexState createState() => AppIndexState();
}

class AppIndexState extends State<AppIndex> {
  int currentIndex = 0;
  List children = [Home(), Container(), Container(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Avatar(),
        backgroundColor: ceoWhite,
        elevation: 0.0,
        actions: [
          MaterialButton(
            onPressed: () {},
            child: Badge(
              badgeColor: ceoPink,
              elevation: 0,
              badgeContent: Text(
                "0",
                style:
                    TextStyle(color: ceoWhite, fontSize: TextSize().p(context)),
              ),
              child: Icon(Icons.shopping_cart_rounded),
            ),
          )
        ],
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
          elevation: 0.0,
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
                  Icons.bar_chart_outlined,
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
