import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/themes/ThemeProvider.dart';
import 'package:provider/provider.dart';
class SettingPage extends StatelessWidget{
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.background,
    appBar: AppBar(title: Text("Settings"), backgroundColor: Theme.of(context).colorScheme.background ,),
    body: Column(
      children: [
        Container(
          decoration:BoxDecoration(color:Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(12) ), 
          margin:const EdgeInsets.only(left: 25 ,top: 10,right: 25),
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Theme.of(context).colorScheme.primary),),
                //Switch Mode
                CupertinoSwitch(value: Provider.of<Themeprovider>(context ,listen: false)
                .isDarkMode
                , onChanged: (value)=>Provider.of<Themeprovider>(context,listen: false)
                .toggleTheme())
              ],
            ),
        )
      ],
    ),
    );
  }
}