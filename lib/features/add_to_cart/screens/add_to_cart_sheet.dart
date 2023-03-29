import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/domain/models/product.dart';
import '../../../core/service_locator.dart';
import '../../../core/utils/string_formatters.dart';
import '../widgets/extra_chip.dart';
import 'add_to_card_view_model.dart';

void showAddToCartSheet(BuildContext context, {required Product product}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => ChangeNotifierProvider<AddToCartViewModel>(
      create: (context) =>
          AddToCartViewModel(currentSandwich: product, repository: locator()),
      child: AdddToCartSheet(
        product: product,
      ),
    ),
  );
}

class AdddToCartSheet extends StatelessWidget {
  const AdddToCartSheet({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment.center,
      child: Consumer<AddToCartViewModel>(
        builder: (context, viewmodel, _) {
          return Column(
            children: [
              const SizedBox(height: 40),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          product.image,
                        ),
                      ),
                    ),
                  ),
                  _PriceTag(product: product)
                ],
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 10),
              Text(
                'Add extras for special discounts!',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  ...viewmodel.extras.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: ExtraChip(
                          extra: e,
                          onTap: () => viewmodel.selectExtra(e, context),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => viewmodel.addProductsToCart(context),
                icon: const Icon(Icons.shopping_bag),
                label: const Text('Add to cart'),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 112, 112, 112),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(
          formatPrice(product.price),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
