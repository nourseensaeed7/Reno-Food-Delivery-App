import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawerTile.dart';
import 'package:fooddelivery/pages/SettingPage.dart';
import 'package:fooddelivery/services/auth/AuthService.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // ── CHANGED: logo inside a card container ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/Reno_horizontal.png',
                height: 90,
              ),
            ),
          ),

          const SizedBox(height: 10),

          MyDrawerTile(
              text: 'Home',
              icon: Icons.home,
              onTap: () => Navigator.pop(context)),
          MyDrawerTile(
            text: 'Settings',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
          ),

          const Spacer(),

          // ── NEW: subtle divider above logout ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Divider(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),

          MyDrawerTile(
              text: 'Log Out', icon: Icons.logout, onTap: logout),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}