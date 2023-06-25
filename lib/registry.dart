import 'package:flutter/material.dart';
import 'package:test/Listings.dart';
import 'package:test/add_listing.dart';
import 'package:test/view_details.dart';
import 'package:test/wallet.dart';
import 'package:test/view_profile.dart';
import 'package:test/properties_owned.dart';
import 'signup.dart';
import 'saved.dart';
import 'package:flutter/gestures.dart';
import 'package:test/smart_contract_link.dart';
import 'package:flutter/material.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';

class PropertyTransfer {
  final String propertyId;
  final String transactionId;
  final double pricePaid;
  final String ownerName;
  final String newOwnerName;
  final String propertyImageUrl;

  PropertyTransfer({
    required this.propertyId,
    required this.transactionId,
    required this.pricePaid,
    required this.ownerName,
    required this.newOwnerName,
    required this.propertyImageUrl,
  });
}

class PropertyTransfersPage extends StatefulWidget {
  const PropertyTransfersPage({Key? key}) : super(key: key);

  @override
  _PropertyTransfersState createState() => _PropertyTransfersState();
}

class _PropertyTransfersState extends State<PropertyTransfersPage> {
  final List<PropertyTransfer> _transfers = [];

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Transfer Registry'),
      ),
      body: ListView.builder(
        itemCount: _transfers.length,
        itemBuilder: (BuildContext context, int index) {
          final transfer = _transfers[index];
          return Card(
            child: Column(
              children: [
                Image.network(transfer.propertyImageUrl),
                ListTile(
                  title: Text(transfer.propertyId),
                  subtitle: Text('Transaction ID: ${transfer.transactionId}\n'
                      'Price Paid: ${transfer.pricePaid}\n'
                      'Previous Owner: ${transfer.ownerName}\n'
                      'New Owner: ${transfer.newOwnerName}'),
                  onTap: () {
                    // could handle tap events here by navigating to a detail
                    // page for the property transfer
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
