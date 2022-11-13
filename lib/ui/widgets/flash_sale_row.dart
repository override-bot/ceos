// ignore_for_file: prefer_is_empty

import 'package:ceos/core/models/product_model.dart';
import 'package:ceos/ui/widgets/product_card.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/flash_percent.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import 'flash_product_card.dart';

class FlashRow extends StatefulWidget {
  const FlashRow({Key? key}) : super(key: key);

  @override
  State<FlashRow> createState() => _FlashRowState();
}

class _FlashRowState extends State<FlashRow> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: FutureBuilder<List<Product>>(
        future: productViewmodel.getFlashSales(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.length != 0) {
            return Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Flash sales ⚡️",
                        style: TextStyle(
                            color: ceoPurple,
                            fontSize: TextSize().h3(context),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FlashProductCard(
                                  discountPercentage: getFlashPercent(
                                      snapshot.data?[index].price,
                                      snapshot.data?[index].discountPrice),
                                  discountPrice:
                                      snapshot.data?[index].discountPrice,
                                  price: snapshot.data?[index].price,
                                  url: snapshot.data?[index].productImage,
                                  productName:
                                      snapshot.data?[index].productName,
                                );
                              }))
                    ]));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            print(snapshot.error);
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 3.6,
                      decoration: BoxDecoration(
                          color: greyOne,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 3.6,
                      decoration: BoxDecoration(
                          color: greyOne,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 3.6,
                      decoration: BoxDecoration(
                          color: greyOne,
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                ));
          } else {
            return Container(
              height: 0,
            );
          }
        },
      ),
    );
  }
}
