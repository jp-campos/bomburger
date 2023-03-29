import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/domain/models/product.dart';
import '../../../core/ui/global_view_models/cart_view_model.dart';
import '../../home/domain/products_repository.dart';
import '../model/extra_wrapper.dart';

class AddToCartViewModel extends ChangeNotifier {
  AddToCartViewModel({
    required this.currentSandwich,
    required ProductsRepository repository,
  }) {
    _repository = repository;
    _init();
  }

  final Product currentSandwich;
  UnmodifiableListView<ExtraWrapper> get extras =>
      UnmodifiableListView(_extras);
  List<ExtraWrapper> _extras = [];

  late final ProductsRepository _repository;

  void selectExtra(ExtraWrapper extraWrapper, BuildContext context) {
    extraWrapper.toggleSelected();
    notifyListeners();
  }

  void addProductsToCart(BuildContext context) {
    final selectedExtras =
        _extras.where((element) => element.isSelected).map((e) => e.product);

    final cartModel = context.read<CartViewModel>();
    final success =
        cartModel.addProducts(selectedExtras.followedBy([currentSandwich]));

    if (success) {
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
          content: const Text(
            "You can't add more than 1 of the same product to the cart (this also includes extras)",
          ),
        ),
      );
    }
  }

  void _init() async {
    final response = await _repository.getAllExtras();
    _extras = response
        .map((product) => ExtraWrapper(isSelected: false, product: product))
        .toList();
    notifyListeners();
  }
}
