import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawer.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage>{
 @override
 Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.background,
    appBar: AppBar(title: Text("home"), backgroundColor: Theme.of(context).colorScheme.background ,),
    drawer: MyDrawer(),//side Menu
  );
 }
}