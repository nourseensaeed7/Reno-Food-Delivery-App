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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length, vsync: this);//no. of categories to be displayed in bar 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort and return a list of food items that belong to this category
  List<Food>_filterMenuByCategory(FoodCategory category, List<Food>fullMenu){
    return fullMenu.where((food)=>food.category==category).toList();
  }

  //return list of foods in the category
  List<Widget> getFoodInThisCategory(List<Food>fullMenu){
    return FoodCategory.values.map((category){
      //get category menue
      List<Food> categoryMenu=_filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          final food=categoryMenu[index];

          // retrun food tile UI
          return MyFoodTile(food: food,
           onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodPage(food: food
           ),)),);
        },
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        body:Consumer<Restourant>(builder: (context, restourant,child)=>
         TabBarView(
          controller: _tabController,
          children:getFoodInThisCategory(restourant.menu),
        ),
        
      ),
      )
      );
  }
}