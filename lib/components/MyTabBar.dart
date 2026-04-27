import 'package:flutter/material.dart';
import 'package:fooddelivery/models/Food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({
    super.key,
    required this.tabController,
});
List<Tab>_buildCategoryTabs(){
  return FoodCategory.values.map((category){
    String name = category.toString().split('.').last;//strip after the . cause the return from the map is FoodCategory.category
    String capitalized = name[0].toUpperCase() + name.substring(1);
    return Tab(
      text: capitalized,
    );
  }).toList();
}
  @override
  Widget build (BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs:_buildCategoryTabs(),
        labelStyle: TextStyle(fontWeight: FontWeight.w900),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}