import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fooddelivery/models/Food.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};
  FoodPage({
    super.key,
    required this.food
  }) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  //method to add to the cart
  void addToCart(Food food, Map<Addon,bool> selectedAddons){

    //close the current ffod page to go back to menu
    Navigator.pop(context);

    List <Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons){
      if (widget.selectedAddons[addon] == true){
        currentlySelectedAddons.add(addon);
      }
    }
    context.read<Restourant>().addToCart(food, currentlySelectedAddons);
  }
  @override
  Widget build(BuildContext context) {
    // ADDED: detect dark/light for glass tint color
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color glassColor = isDark
        ? Colors.white.withOpacity(0.07)   // ADDED: dark glass tint
        : Colors.white.withOpacity(0.45);  // ADDED: light glass tint
    final Color glassBorder = isDark
        ? Colors.white.withOpacity(0.12)   // ADDED: dark glass border
        : Colors.white.withOpacity(0.6);   // ADDED: light glass border

    return Scaffold(
      // ADDED: background gradient using your theme colors
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          // ADDED: top background blob for depth (iOS-style ambient glow)
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.35),
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            right: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.18),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ADDED: safe area top spacing
                  SizedBox(height: MediaQuery.of(context).padding.top + 8),

                  // ADDED: back button with glass pill
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: glassColor,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: glassBorder),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new_rounded,
                              color: Theme.of(context).colorScheme.primary, size: 18),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Image — unchanged, added shadow + border
                  Container(
                    // ADDED: soft shadow behind image card
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                          blurRadius: 32,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24), // ADDED: slightly larger radius
                      child: Image.asset(
                        widget.food.imgPath,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ADDED: glass card wrapping name, price, description
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: glassColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: glassBorder, width: 1.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name + Price row — unchanged logic
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.food.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                // ADDED: price in a small glass pill badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: glassBorder),
                                  ),
                                  child: Text(
                                    '\$${widget.food.price}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.3)),

                            // Description — unchanged
                            Text(
                              widget.food.desc,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ADDED: glass card wrapping addons section
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: glassColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: glassBorder, width: 1.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Add-ons label — unchanged
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                              child: Text(
                                "Add-ons",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.3)),

                            // Add-ons list — unchanged logic
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: widget.food.availableAddons.length,
                              itemBuilder: (context, index) {
                                Addon addon =
                                widget.food.availableAddons[index];
                                return CheckboxListTile(
                                  // ADDED: active color from your theme
                                  activeColor: Theme.of(context).colorScheme.secondary,
                                  checkColor: Colors.white,
                                  title: Text(addon.name),
                                  subtitle: Text(
                                    '\$${addon.price}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                  value: widget.selectedAddons[addon],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget.selectedAddons[addon] = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Add to cart button — ADDED glass + gradient style
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // ADDED: gradient using your secondary + tertiary colors
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        // ADDED: glow shadow under button
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // ADDED: transparent so gradient shows through
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => addToCart(widget.food, widget.selectedAddons),
                      child: const Text(
                        "Add to Cart",
                        // ADDED: style for button text
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}