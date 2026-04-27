import 'package:flutter/material.dart';
import 'package:fooddelivery/auth/LoginOrRegist.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/themes/ThemeProvider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    MultiProvider(providers: [
    //THEME
    ChangeNotifierProvider(create: (context)=>Themeprovider()),
    //RESTOURANT
    ChangeNotifierProvider(create: (context)=>Restourant()),
    ],
    child:const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegist(),
      theme:Provider.of<Themeprovider>(context).themeData,
    );
  }
}
