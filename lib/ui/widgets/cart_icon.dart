import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/cart_viewmodel.dart';
import '../../utils/color.dart';

class CartIcon extends StatefulWidget {
  final VoidCallback? onPressed;

  const CartIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    CartViewmodel _cartViewmodel = Provider.of<CartViewmodel>(context);
    int itemCount = _cartViewmodel.overallCartItemCount;
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: ceoBlack,
          ),
          onPressed: widget.onPressed,
        ),
        if (itemCount > 0)
          Positioned(
            right: 2,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                itemCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
