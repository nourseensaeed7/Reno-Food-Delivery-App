import 'package:flutter/material.dart';
import 'package:fooddelivery/models/Food.dart';

class MyQuantitySelector extends StatelessWidget {
  final int quantity;
  final Food food;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MyQuantitySelector({
    super.key,
    required this.food,
    required this.onDecrement,
    required this.onIncrement,
    required this.quantity,
  });

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .inversePrimary
            .withOpacity(0.22),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.25),
        ),
      ),
      padding: const EdgeInsets.all(7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.remove,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
            child: SizedBox(
              width: 20,
              child: Center(child: Text(quantity.toString())),
            ),
          ),

          GestureDetector(
            onTap: onIncrement,
            child: Icon(
              Icons.add,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
