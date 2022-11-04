// ignore_for_file: prefer_const_constructors

import 'package:ceos/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';

class AppIndex extends StatefulWidget {
  @override
  AppIndexState createState() => AppIndexState();
}

class AppIndexState extends State<AppIndex> {
  int currentIndex = 0;
  List children = [Container(), Container(), Container(), Container()];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
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
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
