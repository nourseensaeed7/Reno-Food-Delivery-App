import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget{
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    //teststyle
    var myPrimaryTextStyle = TextStyle(color: Theme.of(context).colorScheme.secondary);
    var mySecondaryTextStyle = TextStyle(color: Theme.of(context).colorScheme.primary);
    return Container(
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.inversePrimary,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 20, right:20, bottom:25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(
          children: [
            Text('Delivery Fee', style: mySecondaryTextStyle),
            Text('\$0.99', style: myPrimaryTextStyle),
          ],
    ),
        //delivery time
        Column(
          children: [
            Text('Delivery Time', style: mySecondaryTextStyle),
            Text('15-30 min', style: myPrimaryTextStyle),
          ],
        ),
      ],
      ),
    );
  }
}