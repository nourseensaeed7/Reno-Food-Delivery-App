import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDescriptionBox.dart';
import 'package:fooddelivery/components/MyDrawer.dart';
import 'package:fooddelivery/components/MySilverAppBar.dart';
import 'package:fooddelivery/components/MyCurrentLocation.dart';
import 'package:fooddelivery/components/MyTabBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const MyCurrentLocation(),
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Text("First Tab Item")),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Text("Second Tab Item")),
            ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Text("Third Tab Item")),
            ],

        ),
      ),
      );

  }
}