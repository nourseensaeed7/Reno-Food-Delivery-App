import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyButton.dart';
import 'package:fooddelivery/components/MyTextField.dart';
import 'package:fooddelivery/pages/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
 class LoginPage extends StatefulWidget{
  final void Function()?onTap;
  const LoginPage({super.key,required this.onTap});
  @override
  State <LoginPage> createState()=>_LoginPageState();
 }
 class _LoginPageState extends State<LoginPage>{
  //text editing controllers
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  //login method
  void login(){
    //navigate homepage
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder:(context)=>const HomePage(),));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Logo
          Image.asset(
            'assets/images/Reno_Logo.jpg',
            height: 150,
          ),
          const SizedBox(height: 25),
          //text
          Text("Welcome Back!",
          style: GoogleFonts.lato(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          ),
          const SizedBox(height: 25),
          //email 
          MyTextField(prefixIcon: Icons.email_outlined,controller: emailController, hintText: "Email", obscureText: false),
          const SizedBox(height: 15),
          //password
          MyTextField(prefixIcon: Icons.lock_outline,controller: passwordController, hintText: "Password", obscureText: true),
          const SizedBox(height: 15),
          //button

          MyButton(text: 'Sign in',
          onTap: login,
          ),
          const SizedBox(height: 15),
          //Register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Not a member?",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),),
            const SizedBox(width: 4),
            MouseRegion(
            cursor: SystemMouseCursors.click,
            child:GestureDetector(
                onTap: widget.onTap,
                child:Text("Register Now",
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
 