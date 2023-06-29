import 'package:flutter/material.dart';
import 'package:test/Listings.dart';
import 'package:test/Listings.dart';
import 'package:test/smart_contract_link.dart';
import 'Listings.dart';
import 'package:provider/provider.dart';
import 'package:test/makeOffer.dart';
import 'view_profile.dart';
import 'wallet.dart';
import 'package:test/properties_owned.dart';

class Offer {
  final String buyerName;
  final String amount;

  Offer({required this.buyerName, required this.amount, required String image, required String price, required String ownerName, required String offeredPrice});
}

/*class OffersReceivedPage extends StatefulWidget {
  final String image;
  final String price;
  final String ownerName;
  final ListedProperties listedProperties; 

  OffersReceivedPage({
    required this.image,
    required this.price,
    required this.ownerName,
    required this.listedProperties, 
    required String imageUrl,
    required String description,
    required String address,
  });

  @override
  _OffersReceivedPageState createState() => _OffersReceivedPageState();
}*/

class _OffersReceivedPageState extends State<OffersReceivedPage> {
  List<Offer> _offers = [
    // The list is left empty to be populated dynamically.
  ];

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('View Listing Offers'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              'Property ID: ${widget.listedProperties.id}', // Access it like this
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                ),
                ),

            SizedBox(height: 16.0),
            Text(
              'Listed Price: ${widget.price}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Offers',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _offers.length,
              itemBuilder: (BuildContext context, int index) {
                final offer = _offers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${offer.buyerName} offers',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${offer.amount}',
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
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'user@email.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('My Wallet'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),
            ListTile(
              title: Text('My properties'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const PropertiesOwnedPage()),
                );
              },
            ),
            ListTile(
              title: Text('My listings'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ListedPropertiesPage(description: '', offers: [], price: null,)),
                );
              },
            ),
            ListTile(
              title: Text('My profile'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProfilePage(name: '', email: '', address: '', phoneNumber: '', ID_number: '', IDnumber: '',)),
                );
              },
            ),
            ListTile(
              title: Text('My profile'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProfilePage(name: '', email: '', address: '', phoneNumber: '', ID_number: '', IDnumber: '',)),
                );
              },
            ),
            ListTile(
              title: Text('My profile'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProfilePage(name: '', email: '', address: '', phoneNumber: '', ID_number: '', IDnumber: '',)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
