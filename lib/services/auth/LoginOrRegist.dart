import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/LoginPage.dart';
import 'package:fooddelivery/pages/RegisterPage.dart';
class LoginOrRegist extends StatefulWidget {
    const LoginOrRegist({super.key});
    @override
    State <LoginOrRegist> createState()=>_LoginOrRegisState();
}
class _LoginOrRegisState extends State <LoginOrRegist>{
  //show login page firstly
  bool showLoginPage=true;
  //toggle between login and register
  void togglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context){
    if(showLoginPage){
      return LoginPage(onTap: togglePages);
    }else{
      return RegisterPage(onTap: togglePages);
    }
  }
}