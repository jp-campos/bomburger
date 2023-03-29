import 'package:hive_flutter/adapters.dart';

import '../../../core/data/models/product_hive.dart';
import '../../../core/database/hive_init.dart';
import '../../../core/domain/models/product.dart';
import '../domain/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  @override
  Future<List<Product>> getAllSandwiches() async {
    final box = Hive.box<List<dynamic>>(sandwichesBoxName);

    final list = box.get(hiveSandwichesKey);
    if (list == null) return [];
    return list.cast<ProductHive>().map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Product>> getAllExtras() async {
    final box = Hive.box<List<dynamic>>(extrasBoxName);
    final list = box.get(hiveExtrasKey);
    if (list == null) return [];
    return list.cast<ProductHive>().map((e) => e.toEntity()).toList();
  }
}
