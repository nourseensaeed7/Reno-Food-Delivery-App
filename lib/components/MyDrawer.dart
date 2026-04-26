import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawerTile.dart';
import 'package:fooddelivery/pages/SettingPage.dart';
class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:Column(
        children: [
           Image.asset(
            'assets/images/Reno_horizontal.png',
            height: 110,
          ),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25.0),
            child:Divider(
              color:Theme.of(context).colorScheme.primary,
            ),
          ),
          MyDrawerTile(text: 'Home', icon: Icons.home, onTap: ()=>Navigator.pop(context)),
          MyDrawerTile(text: 'Settings', icon: Icons.settings,
            onTap: (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const SettingPage()));
            }),
          const Spacer(),
          MyDrawerTile(text: 'Log Out', icon: Icons.logout, onTap: (){}),
          const SizedBox(height: 5,)
        ],
      )
    );
  }
}