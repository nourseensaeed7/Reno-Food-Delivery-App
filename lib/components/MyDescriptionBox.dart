import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(
          left: 20, right: 20, bottom: 25),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .inversePrimary
            .withOpacity(0.30),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: const [
          Column(
            children: [
              Text("Delivery Fee"),
              SizedBox(height: 5),
              Text("\$0.99"),
            ],
          ),
          Column(
            children: [
              Text("Delivery Time"),
              SizedBox(height: 5),
              Text("15-30 min"),
            ],
          ),
        ],
      ),
    );
  }
}