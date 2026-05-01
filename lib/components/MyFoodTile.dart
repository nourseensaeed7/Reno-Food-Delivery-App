import 'package:flutter/material.dart';
import 'package:fooddelivery/models/Food.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class MyFoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const MyFoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.20),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style:
                              GoogleFonts.playfairDisplay(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary,
                                fontWeight:
                                FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              '\$${food.price}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              food.desc,
                              style: GoogleFonts.lato(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary,
                                fontWeight:
                                FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 15),

                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(18),
                        child: Image.asset(
                          food.imgPath,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        Divider(
          color: Theme.of(context).colorScheme.primary,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
  }
}