import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/global_view_models/cart_view_model.dart';
import '../../../core/ui/widgets/app_bar_title.dart';
import '../../../core/utils/string_formatters.dart';
import 'cart_summary_view_model.dart';

class CartSummary extends StatelessWidget {
  static const routeName = '/cart_summary';
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const AppbarTitle(title: 'Cart'),
      ),
      body: Consumer<CartViewModel>(
        builder: ((context, cartViewModel, _) {
          if (cartViewModel.productCount == 0) {
            return const Center(child: Text('Empty cart'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Text(
                    'Your order',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 15),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: cartViewModel.productCount,
                    itemBuilder: (context, index) {
                      final product = cartViewModel.products[index];
                      return _CartItem(
                        label: product.name,
                        value: product.price,
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  _CartItem(label: 'Subtotal', value: cartViewModel.subtotal),
                  const SizedBox(height: 10),
                  if (cartViewModel.discount != 0)
                    _DiscountContainer(
                      child: _CartItem(
                        label: formatDiscount(cartViewModel.discountPercent),
                        value: -cartViewModel.discount,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        formatPrice(cartViewModel.total),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ChangeNotifierProvider<CartSummaryViewModel>(
                    create: (_) => CartSummaryViewModel(),
                    child: const _BillingData(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BillingData extends StatelessWidget {
  const _BillingData();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CartSummaryViewModel>();
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Billing Data',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const Icon(Icons.receipt_long, color: Colors.grey)
              ],
            ),
            TextFormField(
              onChanged: viewModel.onNameChange,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                label: Text('Name'),
                fillColor: Colors.black,
              ),
            ),
            ElevatedButton.icon(
              onPressed: viewModel.isCheckoutEnabled
                  ? () => viewModel.onCheckout(context)
                  : null,
              icon: const Icon(Icons.payments),
              label: const Text('Checkout', style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}

class _DiscountContainer extends StatelessWidget {
  const _DiscountContainer({required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      ),
      child: child,
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.label,
    required this.value,
    this.color = Colors.black,
    this.fontSize = 16,
  });
  final String label;
  final double value;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: color, fontSize: fontSize),
        ),
        Text(
          formatPrice(value),
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
