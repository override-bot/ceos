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
  final Api _api = Api("products");
  List<Product> products = [];

  List<Product> flashes = [];
  void setCategory(scategory) {
    _category = scategory;
    notifyListeners();
  }

  Future<List<Product>> getRecommendedItems() async {
    var result = await _api.getWhereIsEqualTo(false, "isFlash");
    products = result.docs
        .map((doc) =>
            Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    products.shuffle();
    return products.take(6).toList();
  }

  Future<List<Product>> getFlashSales() async {
    var result = await _api.getRecentDocs();
    flashes = result.docs
        .map((doc) =>
            Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return flashes;
  }

  setImage(photo) {
    _image = photo;
    notifyListeners();
  }

  Future<void> setImageUrl(image, fileName) async {
    _imageUrl = await Storage().uploadImage(image, fileName, "products");
  }

  Future addProduct(Product data) async {
    var result = await _api.addData(data.toJson());
    return result;
  }
}
