import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openlocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Location"),
        content: const TextField(
          decoration: const InputDecoration(hintText: "Search Adress..."),
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ]
     ),
    );
  }

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0 ,vertical:5.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deliver now", style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            GestureDetector(
              onTap: () => openlocationSearchBox(context),
                child: Row(
                  children: [
                  //adress
                  Text("69801 HollyWood Blv",
                    style:TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                //drop down menu
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
            ),
          ],
        ),
      );
    }


  }