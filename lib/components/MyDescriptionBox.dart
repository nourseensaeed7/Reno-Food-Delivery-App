import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ── CHANGED: card style matching the rest of the app ──
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Delivery Fee',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary)),
              Text('\$0.99',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          // ── NEW: small divider between the two info blocks ──
          Container(
            height: 30,
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          Column(
            children: [
              Text('Delivery Time',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary)),
              Text('15-30 min',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}