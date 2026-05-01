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

  // ── NEW: load saved cart before app starts ──
  final restourant = Restourant();
  await restourant.loadCartFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themeprovider()),
        // ── CHANGED: use the already-created instance instead of creating new ──
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