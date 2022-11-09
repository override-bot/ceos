import 'dart:io';

import 'package:ceos/ui/shared/icon_circle.dart';
import 'package:ceos/ui/shared/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/product_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/categories.dart';
import '../../utils/color.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/dropdown.dart';

class AddProduct extends StatefulWidget {
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _pnameField = TextEditingController();
  TextEditingController _priceField = TextEditingController();
  TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
    final productViewmodel = Provider.of<ProductViewmodel>(context);
    Future getImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        productViewmodel.setImage(_image);
      } else {
        return;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ceoWhite,
        leading: IconButton(
          onPressed: () {
            RouteController().pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ceoPurple,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 10, right: 5),
        height: double.infinity,
        color: ceoWhite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconCircle(
                icon: Icons.add_business,
                color: ceoPurple,
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  "Add a new product",
                  style: TextStyle(
                      color: ceoPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().h2(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: Text(
                  "Add a products for your customers to buy. No commission required.🎉",
                  style: TextStyle(
                      color: ceoPurpleGrey, fontSize: TextSize().h3(context)),
                ),
              ),
              Container(
                height: 20,
              ),
              Center(
                child: CustomTextField(
                    hintText: "Product name", controller: _pnameField),
              ),
              Center(
                child: CustomTextField(
                    hintText: "Price (in Naira)", controller: _pnameField),
              ),
              CeoDropdown(
                hint: "category",
                items: categories,
                value: productViewmodel.category,
                onChanged: (text) {
                  productViewmodel.setCategory(text);
                  print(productViewmodel.category);
                },
              ),
              Center(
                child: CustomTextField(
                  hintText: "Description",
                  controller: _pnameField,
                  minLines: 5,
                ),
              ),
              Container(
                height: 20,
              ),
              Center(
                  child: MaterialButton(
                      onPressed: getImage,
                      child: productViewmodel.image == null
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // ignore: prefer_const_constructors
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                    Icon(
                                      Icons.image,
                                      size: 80,
                                      color: ceoPurple,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 6),
                                      child: Text(
                                        "Add product image",
                                        style: TextStyle(
                                            color: ceoPurple,
                                            fontSize: TextSize().h3(context)),
                                      ),
                                    ),
                                  ])),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: greyOne),
                            )
                          : Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image:
                                          FileImage(productViewmodel.image!)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: greyOne)))),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                margin: EdgeInsets.only(bottom: 10, top: 25),
                decoration: BoxDecoration(
                  color: ceoPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print(userViewModel.firstname);
                  },
                  child: Text(
                    "Add product",
                    style: TextStyle(
                        color: ceoWhite, fontSize: TextSize().h3(context)),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
