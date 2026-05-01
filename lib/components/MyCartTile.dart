import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyQuantitySelector.dart';
import 'package:fooddelivery/models/CartItem.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restourant>(
      builder: (context, restourant, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    cartItem.food.imgPath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),

                // Middle: name, price, addons
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cartItem.food.name,
                        style: GoogleFonts.playfairDisplay(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '\$${cartItem.food.price}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (cartItem.selectedAddons.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: cartItem.selectedAddons
                              .map(
                                (addon) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${addon.name} (+\$${addon.price})',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Right: quantity selector always centered
                MyQuantitySelector(
                  quantity: cartItem.quantity,
                  food: cartItem.food,
                  onDecrement: () {
                    restourant.removeFromCart(cartItem);
                  },
                  onIncrement: () {
                    restourant.addToCart(
                      cartItem.food,
                      cartItem.selectedAddons,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}