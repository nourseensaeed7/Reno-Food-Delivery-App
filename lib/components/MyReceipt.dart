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
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Column(
        children: [
          const Text(
            "Thank you for your order!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Center(
                  child: Text(
                    "R E C E I P T",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Cart items mapped from restaurant model
                ...cart.map((CartItem cartItem) {
                  // base price + addons price
                  double itemPrice =
                      cartItem.food.price +
                      cartItem.selectedAddons.fold(
                        0.0,
                        (sum, addon) => sum + addon.price,
                      );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReceiptRow(
                        "${cartItem.food.name} x${cartItem.quantity}",
                        "\$${(itemPrice * cartItem.quantity).toStringAsFixed(2)}",
                      ),
                      // show addons if any
                      if (cartItem.selectedAddons.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 4),
                          child: Text(
                            "  + ${cartItem.selectedAddons.map((a) => a.name).join(', ')}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  );
                }),

                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Total
                _buildReceiptRow(
                  "Total",
                  "\$${total.toStringAsFixed(2)}",
                  isBold: true,
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    "Estimated delivery: 25-35 mins",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 20),

                MyButton(
                  text: "Back to Home",
                  onTap: () {
                    context.read<Restourant>().clearCart();
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
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

  Widget _buildReceiptRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
