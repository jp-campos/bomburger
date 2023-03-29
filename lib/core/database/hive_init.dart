import 'package:hive_flutter/adapters.dart';

import '../data/models/product_hive.dart';

const hiveSandwichesKey = 'hiveSandwichesKey';
const hiveExtrasKey = 'hiveExtrasKey';

const sandwichesBoxName = 'sandwiches';
const extrasBoxName = 'extras';

const extraType = 'extra';
const sandwichType = 'sandwich';

Future<void> hiveInit() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductHiveAdapter());

  final sandwichBox = await Hive.openBox<List<dynamic>>(sandwichesBoxName);
  final extrasBox = await Hive.openBox<List<dynamic>>(extrasBoxName);

  sandwichBox.delete(hiveSandwichesKey);
  extrasBox.delete(hiveExtrasKey);
  if (sandwichBox.isEmpty) {
    await _addSandwiches(sandwichBox);
  }

  extrasBox.delete(hiveExtrasKey);
  if (extrasBox.isEmpty) {
    await _addExtras(extrasBox);
  }
}

Future<void> _addExtras(Box extrasBox) async {
  extrasBox.put(hiveExtrasKey, [
    ProductHive(
      name: 'Soft drink',
      price: 2.5,
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhpuW6NRhEiDR-CW2IJE2K1YRhuuahBhOpqb93PLOKKosiFZF1ituy1193DJKYF6H0zQg&usqp=CAU',
      type: extraType,
    ),
    ProductHive(
      name: 'Fries',
      price: 2,
      image:
          'https://www.recipetineats.com/wp-content/uploads/2022/09/Crispy-Fries_8.jpg?w=500&h=500&crop=1',
      type: extraType,
    ),
  ]);
}

Future<void> _addSandwiches(Box sandwichBox) async {
  await sandwichBox.put(hiveSandwichesKey, [
    ProductHive(
      name: 'Burger',
      price: 5,
      image:
          'https://www.publicdomainpictures.net/pictures/240000/nahled/burger-on-a-wooden-backgound.jpg',
      type: sandwichType,
    ),
    ProductHive(
      name: 'Bacon',
      price: 7,
      image:
          'https://bluejeanchef.com/uploads/2019/03/bacon-burger-640x800.jpg',
      type: sandwichType,
    ),
    ProductHive(
      name: 'Egg',
      price: 4.5,
      image: 'https://www.eggs.ca/assets/RecipePhotos/Egg-Burger.jpg',
      type: sandwichType,
    )
  ]);
}
