import 'dart:io';

import 'package:ceos/core/models/user_model.dart';
import 'package:ceos/core/services/api.dart';
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
  File? _image;
  String? get firstname => _firstName;
  String? get lastname => _lastName;
  String? get bio => _bio;
  String? get phoneNumber => _phoneNumber;
  String? get whatsappLink => _whatsappLink;
  String? get twitterLink => _twitterLink;
  String? get instagramLink => _instagramLink;
  String? get imageUrl => _imageUrl;
  File? get image => _image;
  final Api _api = Api("users");
  Future<void> setImageUrl(image, uid) async {
    _imageUrl = await Storage().uploadImage(image, uid, "Users");
  }

  Future<Ceo> getCeoById(id) async {
    var doc = await _api.getDocumentById(id);
    return Ceo.fromMap(doc.data() as Map<String, dynamic>, id);
  }

  Future<bool> checkIfUser(userId) async {
    var result = await _api.getDocumentById(userId);
    if (result.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future addUser(Ceo data, uid) async {
    var result = await _api.setData(data.toJson(), uid);
    return result;
  }

  Future addCeoScore(userId) async {
    var result = await getCeoById(userId);
    int? ceoScore = result.ceoScore;
    _api.updateDocument("ceoScore", ceoScore! + 1, userId);
  }

  setImage(photo) {
    _image = photo;
    notifyListeners();
  }

  void setFirstname(text) {
    _firstName = text;
  }

  void setLastname(text) {
    _lastName = text;
  }

  void setPhoneNumber(text) {
    _phoneNumber = text;
  }

  void setWhatsappLink(text) {
    _whatsappLink = text;
  }

  void setInstagramLink(text) {
    _instagramLink = text;
  }

  void setTwitterLink(text) {
    _twitterLink = text;
  }
}
