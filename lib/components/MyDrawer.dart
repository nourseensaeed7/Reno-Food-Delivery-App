import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyDrawerTile.dart';
import 'package:fooddelivery/pages/SettingPage.dart';
import 'package:fooddelivery/services/auth/AuthService.dart';
class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});
  //log out
  void logout(){
    final authService=AuthService();
    authService.signOut();
  }


  @override
  Widget build(BuildContext context){
    return Drawer(
        backgroundColor: Theme.of(context)
            .colorScheme
            .background
            .withOpacity(0.95),
        child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/Reno_horizontal.png',
                  height: 95,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25),
                  child: Divider(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.25),
                  ),
                ),
          MyDrawerTile(text: 'Home', icon: Icons.home, onTap: ()=>Navigator.pop(context)),
          MyDrawerTile(text: 'Settings', icon: Icons.settings,
            onTap: (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const SettingPage()));
            }),
          const Spacer(),
          MyDrawerTile(text: 'Log Out', icon: Icons.logout, onTap: logout),
          const SizedBox(height: 5,)
        ],
      )
        ),
    );
  }
}