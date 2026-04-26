import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerTile extends StatelessWidget{
  final String text;
  final IconData? icon;
  final void Function()?onTap;
  const MyDrawerTile({super.key,
  required this.text,
  required this.icon,
  required this.onTap,
  });
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.only(left:0.0 ),
    child:ListTile(
    title:Text(text,
        style:
         GoogleFonts.poppins(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
    leading: Icon(icon,color:Theme.of(context).colorScheme.primary,),
    onTap: onTap,
    )
    );
  }
}
