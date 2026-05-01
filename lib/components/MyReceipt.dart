import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyButton.dart';
import 'package:fooddelivery/models/CartItem.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/pages/HomePage.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = context.read<Restourant>();
    final cart = restaurant.cart;
    final total = restaurant.getTotalPrice();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Thank you for your order!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "R E C E I P T",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4),
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                const SizedBox(height: 8),

                // Cart items
                ...cart.map((CartItem cartItem) {
                  double itemPrice = cartItem.food.price +
                      cartItem.selectedAddons
                          .fold(0.0, (sum, addon) => sum + addon.price);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow(
                        context,
                        "${cartItem.food.name} x${cartItem.quantity}",
                        "\$${(itemPrice * cartItem.quantity).toStringAsFixed(2)}",
                      ),
                      if (cartItem.selectedAddons.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 4),
                          child: Text(
                            "+ ${cartItem.selectedAddons.map((a) => a.name).join(', ')}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.6)),
                          ),
                        ),
                    ],
                  );
                }),

                const SizedBox(height: 8),
                Divider(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                const SizedBox(height: 8),

                _buildRow(context, "Total", "\$${total.toStringAsFixed(2)}",
                    isBold: true),

                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "Estimated delivery: 25-35 mins",
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.6),
                        fontSize: 13),
                  ),
                ),
                const SizedBox(height: 20),

                MyButton(
                  text: "Back to Home",
                  onTap: () {
                    // ── FIXED: clear cart then navigate to HomePage,
                    //    removing all previous routes from the stack ──
                    context.read<Restourant>().clearCart();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String amount,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14)),
          Text(amount,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14)),
        ],
      ),
    );
  }
}