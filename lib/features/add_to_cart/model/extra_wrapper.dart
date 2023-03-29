import '../../../core/domain/models/product.dart';

class ExtraWrapper {
  ExtraWrapper({required this.isSelected, required this.product});

  bool isSelected;
  final Product product;

  void toggleSelected() => isSelected = !isSelected;
}
