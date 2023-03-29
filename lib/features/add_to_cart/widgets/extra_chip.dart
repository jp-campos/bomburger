import 'package:flutter/material.dart';

import '../../../core/utils/string_formatters.dart';
import '../model/extra_wrapper.dart';

class ExtraChip extends StatelessWidget {
  const ExtraChip({
    required this.extra,
    required this.onTap,
    super.key,
  });

  final ExtraWrapper extra;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderDecoration = BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: borderDecoration,
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(extra.product.image),
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(extra.product.name),
                          Text(formatPrice(extra.product.price)),
                        ],
                      ),
                    ),
                    const Icon(Icons.add),
                  ],
                ),
                _SelectedExtra(
                  selectedOpacity: selectedOpacity,
                  name: extra.product.name,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  double get selectedOpacity => extra.isSelected ? 1 : 0;
}

class _SelectedExtra extends StatelessWidget {
  const _SelectedExtra({
    Key? key,
    required this.selectedOpacity,
    required this.name,
  }) : super(key: key);

  final double selectedOpacity;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: selectedOpacity,
        duration: const Duration(milliseconds: 200),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
            gradient: LinearGradient(
              colors: [Colors.green, Color.fromARGB(255, 54, 179, 58)],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Icon(Icons.check, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
