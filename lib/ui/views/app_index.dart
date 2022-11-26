// ignore_for_file: prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:ceos/ui/views/categories.dart';
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
  List children = [Home(), CategoriesView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: currentIndex == 1
            ? Text(
                'Categories',
                style: TextStyle(
                    color: ceoPurple, fontSize: TextSize().h2(context)),
              )
            : null,
        leading: currentIndex != 3 ? Avatar() : null,
        backgroundColor: ceoWhite,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: ceoPurple,
              )),
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
