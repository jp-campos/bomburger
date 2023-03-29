import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({required this.itemCount, required this.onTap, super.key});

  final int itemCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.shopping_cart),
        ),
        AnimatedScale(
          duration: const Duration(milliseconds: 250),
          scale: itemCount > 0 ? 1.1 : 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                itemCount.toString(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
