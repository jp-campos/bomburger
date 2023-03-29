import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../../domain/models/product.dart';
import '../../utils/math_utils.dart';

class CartViewModel extends ChangeNotifier {
  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);
  final List<Product> _products = [];
  int get productCount => _products.length;

  double get subtotal => _products.map((e) => e.price).reduce(
        (a, b) => a + b,
      );

  double get discountPercent => _discountPercent ??= _getDiscount();
  double? _discountPercent;

  double get discount => twoSignificantFigures(
        discountPercent * subtotal,
      );
  double get total => subtotal - discount;

  bool addProduct(Product product) {
    if (_productAlreadyInCart(product)) return false;
    _checkIfDiscountApplies();
    _products.add(product);
    return true;
  }

  bool addProducts(Iterable<Product> producstsToAdd) {
    for (final product in producstsToAdd) {
      final success = addProduct(product);
      if (!success) {
        notifyListeners();
        return false;
      }
    }
    notifyListeners();
    return true;
  }

  bool _productAlreadyInCart(Product product) =>
      _products.any((p) => p.name == product.name);

  void _checkIfDiscountApplies() => _discountPercent = _getDiscount();

  double _getDiscount() {
    if (!_products.any((element) => element.isExtra)) return 0;

    const baseDiscountWithExtras = 0.05;
    const softDrinkDiscount = 0.1;
    const friesDiscount = 0.05;

    double currentDiscount = baseDiscountWithExtras;

    //TODO: Replace with a constant or enum
    if (_products.any((element) => element.name == 'Fries')) {
      currentDiscount += friesDiscount;
    }
    //TODO: Replace with a constant or enum
    if (_products.any((element) => element.name == 'Soft drink')) {
      currentDiscount += softDrinkDiscount;
    }

    return currentDiscount;
  }

  void emptyCart() {
    _products.clear();
    _checkIfDiscountApplies();
    notifyListeners();
  }
}
