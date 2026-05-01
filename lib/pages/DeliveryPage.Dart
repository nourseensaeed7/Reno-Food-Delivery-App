import 'package:flutter/material.dart';
import 'package:fooddelivery/components/MyReceipt.dart';
import 'package:fooddelivery/models/Restourant.dart';
import 'package:fooddelivery/services/database/FireStore.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final FireStoreService db = FireStoreService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String receipt = context.read<Restourant>().displayCartReceipt();
      db.saveOrderToDatabase(receipt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: const Text("Delivery"),
      ),
      body: const SingleChildScrollView(
        child: MyReceipt(),
      ),
    );
  }
}