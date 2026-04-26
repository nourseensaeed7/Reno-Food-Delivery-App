import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyButton.dart';
import 'package:fooddelivery/components/MyTextField.dart';
import 'package:google_fonts/google_fonts.dart';

 class RegisterPage extends StatefulWidget{
  final void Function()?onTap;
  const RegisterPage({super.key,required this.onTap});
  @override
  State <RegisterPage> createState()=>_RegisterPageState();
 }
 class _RegisterPageState extends State<RegisterPage>{
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Image.asset(
            'assets/images/Reno_Logo.jpg',
            height: 150,
          ),
          const SizedBox(height: 25),
          //text
          Text("Let's Create an Account for you",
          style: GoogleFonts.lato(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),),
          const SizedBox(height: 25),
          //email 
          MyTextField(prefixIcon: Icons.email_outlined,controller: emailController, hintText: "Email", obscureText: false),
          const SizedBox(height: 15),
          //password
          MyTextField(prefixIcon: Icons.lock_outline,controller: passwordController, hintText: "Password", obscureText: true),
          const SizedBox(height: 15),
          //confirm password
          MyTextField(prefixIcon: Icons.enhanced_encryption_outlined,controller: confirmPasswordController, hintText: "Confirm Password", obscureText: true),
          const SizedBox(height: 15),
          //button
          MyButton(text: 'Sign up',
          onTap: (){},),
          const SizedBox(height: 15),
          //sign in button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Already have an account?",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),),
            const SizedBox(width: 4),
            MouseRegion(
            cursor: SystemMouseCursors.click,
            child:GestureDetector(
                onTap: widget.onTap,
                child:Text("Log in here",
                style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
            ),)
            ,)
            )
          ],)
        ],
      ),
    );
  }
 }
 