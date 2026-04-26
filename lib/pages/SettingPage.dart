import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawer.dart';
class SettingPage extends StatelessWidget{
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.background,
    appBar: AppBar(title: Text("Settings"), backgroundColor: Theme.of(context).colorScheme.background ,),
    drawer: MyDrawer(),//side Menu
    );
  }
}