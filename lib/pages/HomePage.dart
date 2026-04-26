import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawer.dart';
import 'package:fooddelivery/components/MySilverAppBar.dart';
import 'package:fooddelivery/components/MyCurrentLocation.dart'; // 👈 add this

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: const Text("Reno"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const MyCurrentLocation(), // 👈 actually placed here now
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ],
        body: Container(color: Colors.blue),
      ),
    );
  }
}