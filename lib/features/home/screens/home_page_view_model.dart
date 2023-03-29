import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../../../core/domain/models/product.dart';
import '../domain/products_repository.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel({required ProductsRepository repository}) {
    _repository = repository;
    _init();
  }

  UnmodifiableListView get sandwiches => UnmodifiableListView(_sandwiches);
  List<Product> _sandwiches = [];
  late final ProductsRepository _repository;

  void _init() async {
    _sandwiches = await _repository.getAllSandwiches();
    notifyListeners();
  }
}
