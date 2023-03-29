import 'math_utils.dart';

String formatPrice(double price) => '\$$price';
String formatDiscount(double discount) =>
    '${(twoSignificantFigures(discount) * 100).ceil()}% OFF';
