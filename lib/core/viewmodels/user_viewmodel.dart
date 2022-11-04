import 'package:ceos/core/services/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserViewmodel extends ChangeNotifier {
  String? _firstName;
  String? _lastName;
  String? _bio;
  String? _phoneNumber;
  String? _whatsappLink;
  String? _twitterLink;
  String? _instagramLink;
  String? _imageUrl;
  String? get firstname => _firstName;
  String? get lastname => _lastName;
  String? get bio => _bio;
  String? get phoneNumber => _phoneNumber;
  String? get whatsappLink => _whatsappLink;
  String? get twitterLink => _twitterLink;
  String? get instagramLink => _instagramLink;
  String? get imageUrl => _imageUrl;
  void setImageUrl(image, uid) async {
    _imageUrl = await Storage().uploadImage(image, uid, "Users");
  }

  void setFirstname(text) {
    _firstName = text;
  }

  void setLastname(text) {
    _lastName = text;
  }
}
