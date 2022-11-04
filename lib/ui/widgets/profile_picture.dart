import 'dart:io';

import 'package:ceos/ui/shared/popup.dart';
import 'package:ceos/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/color.dart';
import '../../utils/font_size.dart';

class ProfilePicture extends StatefulWidget {
  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);
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
          //  alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ceoWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  "Complete registration 2/3",
                  style: TextStyle(
                      color: ceoPurple, fontSize: TextSize().p(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Add a profile picture",
                  style: TextStyle(
                      color: ceoPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().h1(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "${userViewModel.firstname} please add a profile picture 📸",
                  style: TextStyle(
                      color: ceoPurpleGrey, fontSize: TextSize().h3(context)),
                ),
              ),
              Expanded(child: Container()),
              Center(
                  child: MaterialButton(
                      onPressed: getImage,
                      child: _image == null
                          ? Container(
                              height: 200,
                              width: 200,
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 100,
                                  color: ceoPurpleGrey,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: greyOne),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(_image!),
                            ))),
              Expanded(child: Container()),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: ceoPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    PopUp().popLoad(context);
                    userViewModel
                        .setImageUrl(_image, userViewModel.firstname)
                        .then((value) {
                      RouteController().pop(context);
                      print(userViewModel.imageUrl);
                    });
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: ceoWhite, fontSize: TextSize().h3(context)),
                  ),
                ),
              )),
              Container(
                height: 20,
              )
            ],
          ),
        ));
  }
}
