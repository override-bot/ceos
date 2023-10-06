import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/core/viewmodels/user_viewmodel.dart';
import 'package:ceos/utils/removeat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/cart_viewmodel.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../utils/color.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../views/cart_view.dart';
import '../views/super_cart_view.dart';
import 'cart_icon.dart';
import 'custom_grid_view.dart';
import 'custom_listtile.dart';

class ShopCard extends StatefulWidget {
  final String? userId;
  const ShopCard({this.userId});

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    final sellerViewmodel = Provider.of<UserViewmodel>(context);
    CartViewmodel _cartViewmodel = Provider.of<CartViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    return FutureBuilder<Ceo>(
        future: sellerViewmodel.getCeoById(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
                onTap: () {
                  _cartViewmodel.setCurrentVendor(widget.userId);
                  RouteController().push(
                      context,
                      CartScreen(
                        shopName: removeAtSymbol(snapshot.data?.username ?? ""),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 3.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: ceoWhite),
                  child: Column(
                    children: [
                      CustomListTile(
                        title: Text(
                          removeAtSymbol(snapshot.data?.username ?? ""),
                          style: TextStyle(
                              fontSize: TextSize().h3(context),
                              fontWeight: FontWeight.w500,
                              color: ceoPurple),
                        ),
                        subtitle: Text(
                          "Personal cart(${_cartViewmodel.getCartItemCountForVendor(widget.userId ?? "")})",
                          style: TextStyle(
                              fontSize: TextSize().p(context),
                              fontWeight: FontWeight.w500,
                              color: ceoPurpleGrey),
                        ),
                        leading: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data?.imageUrl ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ceoPurple,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            RouteController().push(
                                context,
                                CustomGridView(
                                  gridCategory: snapshot.data?.username,
                                  action: CartIcon(
                                    onPressed: () {
                                      RouteController()
                                          .push(context, SuperCartScreen());
                                    },
                                  ),
                                  categoryProducts: productViewmodel
                                      .getCeoProducts(widget.userId),
                                ));
                          },
                          child: Text(
                            "Continue Shopping",
                            style: TextStyle(
                                color: ceoWhite,
                                fontSize: TextSize().h3(context)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          } else {
            return Container();
          }
        });
  }
}
