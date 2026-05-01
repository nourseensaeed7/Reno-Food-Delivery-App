import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/themes/ThemeProvider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  // Helper to build each settings row — keeps code clean
  Widget _buildTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 16, bottom: 4),
            child: Text("Appearance",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600)),
          ),

          // Dark mode toggle — original feature, kept exactly the same
          _buildTile(
            context: context,
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            trailing: CupertinoSwitch(
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 28, top: 16, bottom: 4),
            child: Text("About",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600)),
          ),

          // App version info tile
          _buildTile(
            context: context,
            icon: Icons.info_outline,
            title: "App Version",
            subtitle: "v1.0.0",
          ),

          // Contact / support tile
          _buildTile(
            context: context,
            icon: Icons.support_agent_outlined,
            title: "Contact Support",
            subtitle: "support@reno.com",
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Can wire up email launch later
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Opening support...")),
              );
            },
          ),

          // Notifications toggle
          _buildTile(
            context: context,
            icon: Icons.notifications_outlined,
            title: "Notifications",
            subtitle: "Order updates & promotions",
            trailing: CupertinoSwitch(
              value: true, // static for now — can wire to SharedPreferences later
              onChanged: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}