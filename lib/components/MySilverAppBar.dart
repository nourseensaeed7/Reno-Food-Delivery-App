import 'package:flutter/material.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySilverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      floating: false,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: title,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(          // 👈 was just empty Padding before
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            child,                   // 👈 child (MyCurrentLocation) finally rendered
            const SizedBox(height: 50),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        expandedTitleScale: 1,
      ),
    );
  }
}