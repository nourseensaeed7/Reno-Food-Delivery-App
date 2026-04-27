import 'package:flutter/material.dart';
import 'package:fooddelivery/models/Food.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFoodTile extends StatelessWidget{
  final Food food; 
  final void Function()? onTap;

  const MyFoodTile({super.key, 
  required this.food,
  required this.onTap,
  });
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
         GestureDetector(
          onTap: onTap,
          child:Padding(padding: const EdgeInsets.all(15.0),
          child:
           Row(children: [
            Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              food.name,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
                Text('\$'+ food.price.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,), 
                  ),
                  const SizedBox(height: 10,),
                Text(food.desc,
                  style:GoogleFonts.lato(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,), 
                ),
              ],
            )
            ),
            const SizedBox(width: 15,),
            
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child:Image.asset(food.imgPath ,height: 150, width: 150,) ,)
          ],
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