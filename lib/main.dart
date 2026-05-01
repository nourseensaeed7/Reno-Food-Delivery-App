import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/services/auth/AuthGate.dart';
import 'package:fooddelivery/firebase_options.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/themes/ThemeProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ── load cart + address before app starts ──
  final restourant = Restourant();
  await restourant.loadCartFromPrefs();

  // ── NEW: load saved theme before app starts ──
  final themeProvider = Themeprovider();
  await themeProvider.loadThemeFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: restourant),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<Themeprovider>(context).themeData,
    );
  }
}