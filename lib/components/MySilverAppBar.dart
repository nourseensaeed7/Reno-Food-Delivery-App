import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/CartPage.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      title: Image.asset('assets/images/Reno_horizontal.png', height: 50),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          // subtle card behind the tab bar
          color: Theme.of(context).colorScheme.background,
          child: title,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              child,
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}