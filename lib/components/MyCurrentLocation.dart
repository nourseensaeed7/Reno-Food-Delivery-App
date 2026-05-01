import 'package:flutter/material.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  // Fix 1: define the controller
  final TextEditingController textController = TextEditingController();

  MyCurrentLocation({super.key});

  void openlocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Location"),
        content: TextField(
          controller: textController, // attach controller to the TextField
          decoration: const InputDecoration(hintText: "Enter Address..."),
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () {
              String newAddress = textController.text;
              // Fix 2: added () after Restourant
              context.read<Restourant>().updateDeliveryAddress(newAddress);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openlocationSearchBox(context),
            child: Row(
              children: [
                Consumer<Restourant>(
                  builder: (context, restourant, child) => Text(
                    restourant.deliveryAddress,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}