class Product {
  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.type,
  });

  final String name;
  final double price;
  final String image;
  final ProductType type;

  bool get isExtra => type == ProductType.extra;
}

enum ProductType {
  sandwich,
  extra,
}
