import 'package:flutter/material.dart';

class BasketProvider with ChangeNotifier {
  List<Map<String, dynamic>> _basketItems = [];

  // Getter for basket items
  List<Map<String, dynamic>> get basketItems => _basketItems;

  // Add product to the basket
  void addProductToBasket(
      String productName, String productImage, double productPrice, int quantity) {
    final existingProductIndex = _basketItems.indexWhere((item) => item['name'] == productName);

    if (existingProductIndex != -1) {
      // If product exists, update the quantity
      _basketItems[existingProductIndex]['quantity'] += quantity;
    } else {
      // If product doesn't exist, add new product
      _basketItems.add({
        'name': productName,
        'image': productImage,
        'price': productPrice,
        'quantity': quantity,
      });
    }

    // Notify listeners after making changes
    notifyListeners();
  }

  // Update product quantity in the basket
  void updateProductQuantity(String productName, int delta) {
    final item = _basketItems.firstWhere((item) => item['name'] == productName);
    item['quantity'] += delta;
    if (item['quantity'] < 1) {
      item['quantity'] = 1; // Prevent negative or zero quantity
    }
    notifyListeners();
  }

  // Remove product from the basket
  void removeProductFromBasket(String productName) {
    _basketItems.removeWhere((item) => item['name'] == productName);
    notifyListeners();
  }

  // Get the total price of all items in the basket
  double get totalPrice {
    return _basketItems.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }
}
