import '../../../core/domain/models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllSandwiches();

  Future<List<Product>> getAllExtras();
}
