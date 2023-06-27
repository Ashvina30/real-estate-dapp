import 'package:flutter/material.dart';
import 'package:test/Listings.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';
import 'makeOffer.dart';

class Offer {
  final String buyerName;
  final String amount;

  Offer({required this.buyerName, required this.amount});
}

class OffersReceivedPage extends StatefulWidget {
  final String image;
  final String price;
  final String ownerName;

  OffersReceivedPage({required this.image, required this.price, required this.ownerName, required ListedProperties, required String address, required String description, required String imageUrl, required ListedProperties property});

  @override
  _OffersReceivedPageState createState() => _OffersReceivedPageState();
}

class _OffersReceivedPageState extends State<OffersReceivedPage> {
  List<Offer> _offers = [];

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('View Listing Offers'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250.0,
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Price: ${widget.price}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Owner: ${widget.ownerName}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 32.0),
          Expanded(
            child: ListView.builder(
              itemCount: _offers.length,
              itemBuilder: (BuildContext context, int index) {
                final offer = _offers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Buyer: ${offer.buyerName}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Amount: ${offer.amount}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle accept button press here
                            },
                            child: Text('Accept'),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              // Handle decline button press here
                            },
                            child: Text('Decline'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
    );
  }
}
