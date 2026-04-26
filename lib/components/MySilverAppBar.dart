import 'package:flutter/material.dart';
class MySilverAppBar extends StatelessWidget{
  final Widget child;
  final Widget title;
  const MySilverAppBar({super.key,
  required this.child,
  required this.title});

  @override
  Widget build(BuildContext context){
    return SliverAppBar(
      backgroundColor:Theme.of(context).colorScheme.background,
      title: title,
      floating: false,
      pinned: true,
      actions: [
        //cart Button
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart))
      ],
      flexibleSpace:FlexibleSpaceBar(
        background: child,
      )
    );
  }
}