// ignore_for_file: prefer_is_empty

import 'package:ceos/core/models/product_model.dart';
import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/ui/widgets/custom_grid_view.dart';
import 'package:ceos/ui/widgets/product_card.dart';
import 'package:ceos/ui/widgets/subButton.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../views/product_details.dart';

class CeoProducts extends StatefulWidget {
  const CeoProducts({Key? key}) : super(key: key);

  @override
  State<CeoProducts> createState() => _CeoProductsState();
}

class _CeoProductsState extends State<CeoProducts> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: FutureBuilder<List<Product>>(
        future:
            productViewmodel.getCeoProducts(productViewmodel.product?.sellerId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.length != 0) {
            return Container(
                margin: EdgeInsets.only(top: 10, left: 11),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Text(
                              "More by this vendor",
                              style: TextStyle(
                                  color: ceoPurple,
                                  fontSize: TextSize().h3(context),
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () {
                                  RouteController().push(
                                      context,
                                      CustomGridView(
                                        action: SubscriptionButton(
                                            uid: productViewmodel
                                                .product?.sellerId),
                                        gridCategory: "More by this vendor",
                                        categoryProducts: productViewmodel
                                            .getCeoProducts(productViewmodel
                                                .product?.sellerId),
                                      ));
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: ceoPurpleGrey,
                                  size: TextSize().custom(15, context),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.8,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  onTapped: () {
                                    RouteController()
                                        .push(context, ProductDetails());
                                    productViewmodel.setCurrentProduct(
                                        snapshot.data?[index]);
                                  },
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
            print(snapshot.error);
            return Container(
              height: 0,
            );
          }
        },
      ),
    );
  }
}
