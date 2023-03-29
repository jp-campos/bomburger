import 'package:flutter/material.dart';

import '../../../features/add_to_cart/screens/add_to_cart_sheet.dart';
import '../../domain/models/product.dart';
import '../../utils/string_formatters.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 150),
            child: UnconstrainedBox(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: Image.network(
                  product.image,
                  height: 100,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  formatPrice(product.price),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                ElevatedButton(
                  onPressed: () {
                    showAddToCartSheet(context, product: product);
                  },
                  child: const Text('Order now'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
