import 'package:flutter/material.dart';
import 'package:test/smart_contract_link.dart';
import 'package:uuid/uuid.dart';
import 'package:test/payment_successful.dart'; // Import PaymentSuccessfulPage
import 'home_page.dart';
import 'package:provider/provider.dart';

class PurchaseOverviewPage extends StatefulWidget {
  final String propertyID;
  final String propertyTitle;
  final double price;
  final double tax;
  final String ownerName;
  final String ownerID;
  final double priceOffered;
  final String imagePath;

  PurchaseOverviewPage({
    required this.propertyID,
    required this.propertyTitle,
    required this.price,
    required this.tax,
    required this.ownerName,
    required this.ownerID,
    required this.priceOffered,
    required this.imagePath,
  });

  @override
  _PurchaseOverviewPageState createState() => _PurchaseOverviewPageState();
}

class _PurchaseOverviewPageState extends State<PurchaseOverviewPage> {
  late String transactionID;

  String generateTransactionId() {
    var uuid = Uuid();
    return uuid.v4(); // Generates a random version 4 UUID
  }

  @override
  void initState() {
    super.initState();
    transactionID = generateTransactionId();
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Overview'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Property ID: ${widget.propertyID}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Property Title: ${widget.propertyTitle}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Price: \$${widget.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tax: \$${widget.tax.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Owner Name: ${widget.ownerName}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Owner ID: ${widget.ownerID}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Price Offered: \$${widget.priceOffered.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Transaction ID: $transactionID',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await contractLink.executePurchase(
                  propertyId: widget.propertyID,
                  price: widget.price,
                  tax: widget.tax,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentSuccessfulPage(
                    amount: widget.price + widget.tax,
                    paymentMethod: 'Ether',
                    transactionID: transactionID,
                    propertyID: widget.propertyID,
                    ownerName: widget.ownerName,
                    taxPaid: widget.tax,
                    pricePaid: widget.price.toStringAsFixed(2),
                  )),
                );
              },
              child: Text('Pay'),
            ),
          ),
        ],
      ),
    );
  }
}
