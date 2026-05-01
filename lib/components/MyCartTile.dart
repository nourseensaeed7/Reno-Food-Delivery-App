import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyQuantitySelector.dart';
import 'package:fooddelivery/models/CartItem.dart';
import 'package:fooddelivery/models/Food.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/pages/FoodPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restourant>(
      builder: (context, restourant, child) {
        return Dismissible(
          // ── NEW: unique key required by Dismissible ──
          key: ValueKey(cartItem.food.name + cartItem.selectedAddons.toString()),
          direction: DismissDirection.endToStart, // swipe left only

          // ── NEW: red delete background revealed on swipe ──
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
          ),

          // ── NEW: called when swipe is completed ──
          onDismissed: (direction) {
            // Remove all quantity of this item at once
            final qty = cartItem.quantity;
            for (int i = 0; i < qty; i++) {
              restourant.removeFromCart(cartItem);
            }
          },

          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      cartItem.food.imgPath,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name, price, addons
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                cartItem.food.name,
                                style: GoogleFonts.playfairDisplay(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            // ── NEW: small edit icon ──
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FoodPage(food: cartItem.food),
                                ),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${cartItem.food.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (cartItem.selectedAddons.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 4,
                            runSpacing: 2,
                            children: cartItem.selectedAddons
                                .map((addon) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                addon.name,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                  fontSize: 10,
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Quantity selector — unchanged
                  MyQuantitySelector(
                    quantity: cartItem.quantity,
                    food: cartItem.food,
                    onDecrement: () => restourant.removeFromCart(cartItem),
                    onIncrement: () => restourant.addToCart(
                        cartItem.food, cartItem.selectedAddons),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}