import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  const MyTextField({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText,
  this.prefixIcon});
  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
     child:TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(//input field outline box normal
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Theme.of(context).colorScheme.primary)
        ),
        focusedBorder: OutlineInputBorder(//input field outline box focused
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)
        ),
        prefixIcon: prefixIcon != null 
            ? Icon(prefixIcon, color: Theme.of(context).colorScheme.primary)
            : null,
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
    ),),);
  }
}