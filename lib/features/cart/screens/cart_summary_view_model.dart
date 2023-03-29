import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/global_view_models/cart_view_model.dart';

class CartSummaryViewModel extends ChangeNotifier {
  String _name = '';
  bool isCheckoutEnabled = false;

  void onNameChange(String value) {
    if (value.isNotEmpty) {
      _name = value;
      if (!isCheckoutEnabled) {
        isCheckoutEnabled = true;
        notifyListeners();
      }
    } else {
      if (isCheckoutEnabled) {
        isCheckoutEnabled = false;
        notifyListeners();
      }
    }
  }

  void onCheckout(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Payment Sucess!'),
        children: [Center(child: Text('Thank you for your purchase $_name'))],
      ),
    );
    context.read<CartViewModel>().emptyCart();
    Navigator.pop(context);
  }
}
