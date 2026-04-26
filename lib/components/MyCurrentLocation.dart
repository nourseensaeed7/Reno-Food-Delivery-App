import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deliver now", style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            Row(
              children: [
                //adress
                Text("69801 HollyWood Blv",
                  style:TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,

                  )

                ),

                //drop down menu
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ],
      );
    }


  }