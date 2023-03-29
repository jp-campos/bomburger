import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/service_locator.dart';
import '../../../core/ui/global_view_models/cart_view_model.dart';
import '../../../core/ui/widgets/app_bar_title.dart';
import '../../../core/ui/widgets/cart_icon.dart';
import '../../../core/ui/widgets/product_card.dart';
import '../../cart/screens/cart_summary.dart';
import 'home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (_) => HomePageViewModel(repository: locator()),
      child: const _HomeLayout(),
    );
  }
}

class _HomeLayout extends StatelessWidget {
  const _HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppbarTitle(
          title: 'BomHamburger',
          showCheeseburger: true,
        ),
        actions: [
          Consumer<CartViewModel>(
            builder: (context, cartViewModel, _) {
              return CartIcon(
                itemCount: cartViewModel.productCount,
                onTap: () =>
                    Navigator.of(context).pushNamed(CartSummary.routeName),
              );
            },
          ),
        ],
      ),
      body: Consumer<HomePageViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'Our menu',
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: viewModel.sandwiches.length,
                  separatorBuilder: ((_, __) => const SizedBox(height: 10)),
                  itemBuilder: ((context, index) {
                    final product = viewModel.sandwiches[index];

                    return ProductCard(
                      product: product,
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
