import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fooddelivery/components/MyButton.dart';
import 'package:fooddelivery/pages/DeliveryPage.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    // Fix 1: use ?.validate() ?? false to safely handle nullable currentState
    if (formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder Name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryPage()),
              ),
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Checkout"),
      ),
body: SingleChildScrollView(
  child: Column(
    children: [
      CreditCardWidget(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: isCvvFocused,
        onCreditCardWidgetChange: (p0) {},
      ),
      CreditCardForm(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        formKey: formKey,
        onCreditCardModelChange: (data) {
          setState(() {
            cardNumber = data.cardNumber;
            expiryDate = data.expiryDate;
            cardHolderName = data.cardHolderName;
            cvvCode = data.cvvCode;
            isCvvFocused = data.isCvvFocused;
          });
        },
      ),
      const SizedBox(height: 20),
      MyButton(onTap: userTappedPay, text: "Pay now"),
      const SizedBox(height: 25),
    ],
  ),
),
    );
  }
}