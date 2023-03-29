import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({
    required this.title,
    this.showCheeseburger = false,
    super.key,
  });
  final String title;
  final bool showCheeseburger;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showCheeseburger) Image.asset('assets/cheeseburger.png', width: 20),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }
}
