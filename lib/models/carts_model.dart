
class CartModel {
  bool? status;
  Data? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List cartItems = [];
  dynamic subTotal;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((v) {
        cartItems.add(v);
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  int? id;
  int? quantity;
  Product? product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inCart = json['in_cart'];
  }
}