class CartItem {
  String name;
  double price;
  int quantity;
  String? imageUrl;
  String shopId;
  String productId;

  CartItem(
      {required this.name,
      required this.price,
      this.quantity = 1,
      required this.productId,
      this.imageUrl,
      required this.shopId});

  double get total => price * quantity;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        name: json['name'] ?? "",
        price: json['price'],
        quantity: json['quantity'],
        imageUrl: json['imageUrl'] ?? "",
        productId: json['productId'],
        shopId: json['shotName'] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'productId': productId,
      'quantity': quantity,
      'imageUrl': imageUrl ?? "",
      'shopName': shopId,
    };
  }
}
