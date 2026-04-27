import 'package:flutter/material.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySilverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.primary,

      // ✅ restaurant name in title slot
      title: const Text("Sunset Diner"),

      // ✅ TabBar pinned at the bottom edge of the app bar
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: title,   // your MyTabBar widget
      ),

      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            child,  // MyCurrentLocation + Divider + MyDescriptionBox
            const SizedBox(height: 40), // space so content doesn't hide behind TabBar
          ],
        ),
      ),
    );
  }
}