import 'package:hive_flutter/adapters.dart';

import '../../database/hive_init.dart';
import '../../domain/models/product.dart';
part 'product_hive.g.dart';

@HiveType(typeId: 0)
class ProductHive {
  ProductHive({
    required this.name,
    required this.price,
    required this.image,
    required this.type,
  });
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String type;

  Product toEntity() {
    ProductType productType;
    switch (type) {
      case sandwichType:
        productType = ProductType.sandwich;
        break;

      default:
        productType = ProductType.extra;
    }

    return Product(name: name, price: price, image: image, type: productType);
  }
}
