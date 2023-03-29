import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/database/hive_init.dart';
import 'core/service_locator.dart';
import 'core/theme/theme.dart';
import 'core/ui/global_view_models/cart_view_model.dart';
import 'features/cart/screens/cart_summary.dart';
import 'features/home/screens/home_page.dart';

void main() async {
  await hiveInit();
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartViewModel>(create: (_) => CartViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        routes: {CartSummary.routeName: (context) => const CartSummary()},
        home: const HomePage(),
      ),
    );
  }
}
