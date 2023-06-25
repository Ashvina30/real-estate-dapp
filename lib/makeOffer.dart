import 'package:flutter/material.dart';
import 'package:test/smart_contract_link.dart';
import 'view_details.dart';
import 'offers_sent.dart';
import 'offers_sent.dart';
import 'package:provider/provider.dart';
import 'Offers_received.dart';

class OfferPage extends StatefulWidget {
  final String image;
  final String price;
  final String ownerName;

  OfferPage({
    required this.image,
    required this.price,
    required this.ownerName,
  });

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  String _offerPrice = '';

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Offer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.image,
              height: 250.0,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Offer Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _offerPrice = value;
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // You need to decide who is the buyer, in this case, I assume it's a hardcoded value
                Offer offer = Offer(
                  buyerName: 'John Doe',
                  amount: _offerPrice,
                );
                // Now, add this `offer` to your `OffersReceivedPage`'s `_offers` list somehow, or a global provider.
                print('Offer price: $_offerPrice');
              },
              child: Text('Make Offer'),
            ),
          ],
        ),
      ),
    );
  }
}
