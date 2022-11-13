// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ceos/ui/widgets/flash_sale_row.dart';
import 'package:ceos/ui/widgets/gifts_row.dart';
import 'package:ceos/ui/widgets/recommended_row.dart';
import 'package:ceos/ui/widgets/subscription_row.dart';
import 'package:ceos/utils/color.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ceoWhite,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [FlashRow(), Recommended(), Subscriptions(), Gifts()],
        ),
      ),
    );
  }
}
