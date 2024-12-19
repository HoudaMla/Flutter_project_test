import 'package:flutter/material.dart';

class BasketProvider with ChangeNotifier {
  List<Map<String, dynamic>> _basketItems = [];

  List<Map<String, dynamic>> get basketItems => _basketItems;

  void addProductToBasket(
      String productName, String productImage, double productPrice, int quantity) {
    final existingProductIndex = _basketItems.indexWhere((item) => item['name'] == productName);

    if (existingProductIndex != -1) {
      _basketItems[existingProductIndex]['quantity'] += quantity;
    } else {
      _basketItems.add({
        'name': productName,
        'image': productImage,
        'price': productPrice,
        'quantity': quantity,
      });
    }

    notifyListeners();
  }

  void updateProductQuantity(String productName, int delta) {
    final item = _basketItems.firstWhere((item) => item['name'] == productName);
    item['quantity'] += delta;
    if (item['quantity'] < 1) {
      item['quantity'] = 1; 
    }
    notifyListeners();
  }

  void removeProductFromBasket(String productName) {
    _basketItems.removeWhere((item) => item['name'] == productName);
    notifyListeners();
  }

  double get totalPrice {
    return _basketItems.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }
}
