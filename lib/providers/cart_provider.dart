import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
