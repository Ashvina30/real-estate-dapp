import 'package:flutter/material.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';

class PaymentSuccessfulPage extends StatelessWidget {
  final double amount;
  final String paymentMethod;
  final String transactionID;
  final String propertyID;
  final String ownerName;
  final double taxPaid;
  final String pricePaid;

  PaymentSuccessfulPage({
    required this.amount,
    required this.paymentMethod,
    required this.transactionID,
    required this.propertyID,
    required this.ownerName,
    required this.taxPaid,
    required this.pricePaid,
  });

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Successful'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 30.0,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Your Payment is Successful',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              'Transaction ID: $transactionID',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Property ID: $propertyID',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Owner Name: $ownerName',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Price Paid: $pricePaid',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
Text(
  'Tax Paid: \$${taxPaid.toStringAsFixed(2)}',
  style: TextStyle(fontSize: 16.0),
),
Spacer(),
Column(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    ElevatedButton(
      onPressed: () {
        // Implement view transactions logic here
      },
      child: Text('View Transactions'),
    ),
    SizedBox(height: 10.0),
    ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Close'),
    ),
  ],
),
Spacer(),
],
),
      )
);
}
}
