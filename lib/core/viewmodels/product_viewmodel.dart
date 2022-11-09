import 'dart:io';

import 'package:ceos/core/models/product_model.dart';
import 'package:flutter/material.dart';

import '../services/api.dart';
import '../services/firebase_storage.dart';

class ProductViewmodel extends ChangeNotifier {
  String? _category;
  String? _imageUrl;
  File? _image;
  String? get category => _category;
  String? get imageUrl => _imageUrl;
  File? get image => _image;
  final Api _api = Api("users");
  void setCategory(scategory) {
    _category = scategory;
    notifyListeners();
  }

  setImage(photo) {
    _image = photo;
    notifyListeners();
  }

  Future<void> setImageUrl(image, fileName) async {
    _imageUrl = await Storage().uploadImage(image, fileName, "products");
  }

  Future addProduct(Product data, uid) async {
    var result = await _api.setData(data.toJson(), uid);
    return result;
  }
}
