import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyReceipt.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {

  FirestoreService db=FirestoreService();
  @override
  void initState(){
    super.initState();
    //submit order into database
    String receipt=context.read<Restourant>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Delivery"),
      ),
      body: Column(
        children: [
          MyReceipt(),
        ],
      ),
    );
  }
}