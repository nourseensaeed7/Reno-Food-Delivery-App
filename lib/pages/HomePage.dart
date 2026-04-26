import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawer.dart';
import 'package:fooddelivery/components/MySilverAppBar.dart';
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
    drawer: MyDrawer(),//side Menu
    body: NestedScrollView(
      headerSliverBuilder:(context,innerBoxIsScrolled)=>[
      MySilverAppBar(
        child:Text(''), 
        title: Text("Home"),
      ),
      ],
      body: Container(color: Colors.blue,),
      )
  );
 }
}