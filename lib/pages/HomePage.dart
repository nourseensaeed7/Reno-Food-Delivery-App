import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDescriptionBox.dart';
import 'package:fooddelivery/components/MyDrawer.dart';
import 'package:fooddelivery/components/MyFoodTile.dart';
import 'package:fooddelivery/components/MySilverAppBar.dart';
import 'package:fooddelivery/components/MyCurrentLocation.dart';
import 'package:fooddelivery/components/MyTabBar.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/models/Food.dart';
import 'package:fooddelivery/pages/FoodPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // ── NEW: scroll controller needed for the Scrollbar ──
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose(); // ── NEW
    super.dispose();
  }

  List<Food> _filterMenuByCategory(
      FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return MyFoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodPage(food: food)),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: Scrollbar(
        // ── NEW: scrollbar wrapping the whole scroll area ──
        controller: _scrollController,
        child: NestedScrollView(
          controller: _scrollController, // ── NEW: linked to scrollbar
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            MySilverAppBar(
              title: MyTabBar(tabController: _tabController),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyCurrentLocation(),
                  Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  const MyDescriptionBox(),
                ],
              ),
            ),
          ],
          body: Consumer<Restourant>(
            builder: (context, restourant, child) => TabBarView(
              controller: _tabController,
              children: getFoodInThisCategory(restourant.menu),
            ),
          ),
        ),
      ),
    );
  }
}