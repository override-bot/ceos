import 'package:cached_network_image/cached_network_image.dart';
import 'package:ceos/core/viewmodels/chatviewmodel.dart';
import 'package:ceos/ui/widgets/ceo_product_row.dart';
import 'package:ceos/ui/widgets/username.dart';
import 'package:ceos/utils/popContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/models/cart_item.dart';
import '../../core/viewmodels/cart_viewmodel.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../utils/color.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var formatter = NumberFormat('#,###,000');
  @override
  Widget build(BuildContext context) {
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    CartViewmodel _cartViewmodel = Provider.of<CartViewmodel>(context);
    ChatViewModel _chatViewmodel = ChatViewModel();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ceoWhite,
          leading: IconButton(
            onPressed: () {
              RouteController().pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ceoPurple,
              size: TextSize().h2(context),
            ),
          ),
          title: Text(
            productViewmodel.product!.category!,
            style: TextStyle(color: ceoPurple, fontSize: TextSize().p(context)),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ceoWhite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.only(right: 10, left: 10, bottom: 7),
                        width: MediaQuery.of(context).size.width / 1.05,
                        height: MediaQuery.of(context).size.width * 1.05,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: AspectRatio(
                              aspectRatio: 2.0,
                              child: CachedNetworkImage(
                                imageUrl: productViewmodel.product!.productImage
                                    .toString(),
                                fit: BoxFit.fill,
                              ),
                            )))),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 12),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productViewmodel.product!.productName!,
                            style: TextStyle(
                                fontSize: TextSize().h3(context),
                                fontWeight: FontWeight.w600,
                                color: ceoPurple),
                          ),
                          Container(
                            height: 5,
                          ),
                          Username(
                            userId: productViewmodel.product?.sellerId,
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Text(
                        productViewmodel.product!.isFlash == false
                            ? formatter.format(productViewmodel.product!.price)
                            : formatter.format(
                                productViewmodel.product!.discountPrice),
                        style: TextStyle(
                            fontSize: TextSize().p(context),
                            fontWeight: FontWeight.w500,
                            color: ceoPurple),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    productViewmodel.product!.description!,
                    style: TextStyle(
                        fontSize: TextSize().p(context),
                        fontWeight: FontWeight.w400,
                        color: ceoPurpleGrey),
                  ),
                ),
                _cartViewmodel.isItemInCartForVendor(
                            CartItem(
                                name:
                                    productViewmodel.product!.productName ?? "",
                                productId: productViewmodel.product!.id ?? "",
                                price:
                                    productViewmodel.product!.price!.toDouble(),
                                imageUrl:
                                    productViewmodel.product!.productImage,
                                shopId:
                                    productViewmodel.product!.sellerId ?? ""),
                            productViewmodel.product!.sellerId ?? "") ==
                        false
                    ? Container(
                        margin: EdgeInsets.only(left: 10, top: 20, bottom: 5),
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          color: ceoPurple,
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            _cartViewmodel.addItemToCartForVendor(
                                CartItem(
                                    name:
                                        productViewmodel.product!.productName ??
                                            "",
                                    productId:
                                        productViewmodel.product!.id ?? "",
                                    price: productViewmodel.product!.price!
                                        .toDouble(),
                                    imageUrl:
                                        productViewmodel.product!.productImage,
                                    shopId:
                                        productViewmodel.product!.sellerId ??
                                            ""),
                                productViewmodel.product!.sellerId ?? "");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                color: ceoWhite,
                              ),
                              Container(
                                width: 4,
                              ),
                              Text(
                                'Add to cart',
                                style: TextStyle(
                                    fontSize: TextSize().p(context),
                                    fontWeight: FontWeight.w600,
                                    color: ceoWhite),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              // Decrease quantity logic
                              _cartViewmodel.decreaseQuantityForVendor(
                                  CartItem(
                                      name: productViewmodel
                                              .product!.productName ??
                                          "",
                                      productId:
                                          productViewmodel.product!.id ?? "",
                                      price: productViewmodel.product!.price!
                                          .toDouble(),
                                      imageUrl: productViewmodel
                                          .product!.productImage,
                                      shopId:
                                          productViewmodel.product!.sellerId ??
                                              ""),
                                  productViewmodel.product!.sellerId ?? "");
                            },
                          ),
                          Text(
                            _cartViewmodel
                                .getQuantityForVendor(
                                    CartItem(
                                        name: productViewmodel
                                                .product!.productName ??
                                            "",
                                        price: productViewmodel.product!.price!
                                            .toDouble(),
                                        imageUrl: productViewmodel
                                            .product!.productImage,
                                        productId:
                                            productViewmodel.product!.id ?? "",
                                        shopId: productViewmodel
                                                .product!.sellerId ??
                                            ""),
                                    productViewmodel.product!.sellerId ?? "")
                                .toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              // Increase quantity logic
                              _cartViewmodel.increaseQuantityForVendor(
                                  CartItem(
                                      name: productViewmodel
                                              .product!.productName ??
                                          "",
                                      productId:
                                          productViewmodel.product!.id ?? "",
                                      price: productViewmodel.product!.price!
                                          .toDouble(),
                                      imageUrl: productViewmodel
                                          .product!.productImage,
                                      shopId:
                                          productViewmodel.product!.sellerId ??
                                              ""),
                                  productViewmodel.product!.sellerId ?? "");
                            },
                          ),
                        ],
                      ),
                CeoProducts()
              ],
            ),
          ),
        ));
  }
}
