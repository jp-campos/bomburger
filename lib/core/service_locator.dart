import 'package:get_it/get_it.dart';

import '../features/home/data/products_repository_impl.dart';
import '../features/home/domain/products_repository.dart';

final locator = GetIt.instance;

void initDependencies() {
  locator.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(),
  );
}
