import 'package:flutter/material.dart';
import 'package:fooddelivery/models/Food.dart';
class FoodPage extends StatefulWidget{
  final Food food;
  const FoodPage({super.key,
  required this.food});
  @override
  State <FoodPage> createState()=>_FoodPageState();
}
class _FoodPageState extends State<FoodPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(

    body:
    Padding(padding: EdgeInsets.all(25.0),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(widget.food.imgPath, width: 350,height: 350, ),
        Column(children: [
        Row(children: [
        Text(widget.food.name),
        Text('\$'+widget.food.price.toString()),
        ],),
        Text(widget.food.desc),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.food.availableAddons.length,
          itemBuilder: (context,index) {
            Addon addon=widget.food.availableAddons[index];
            return CheckboxListTile(
              title: Text(addon.name),
              subtitle: Text(addon.price.toString()),
              value: false,
              onChanged: (value){},
              );
          },
        ),
        ],)
      ],
    )
    )
    ); 

  }
}