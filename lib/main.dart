import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/services/auth/AuthGate.dart';
import 'package:fooddelivery/firebase_options.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/themes/ThemeProvider.dart';
import 'package:provider/provider.dart';
void main() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home:const AuthGate(),
      theme:Provider.of<Themeprovider>(context).themeData,
    );
  }
}
