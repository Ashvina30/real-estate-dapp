import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:test/Listings.dart';
import 'package:test/home_page.dart';
import 'package:test/add_listing.dart' hide Listing;
import 'wallet.dart';
import 'saved.dart' hide Listing;
import 'properties_owned.dart';
import 'view_profile.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';

class PropertyDetailsPage extends StatefulWidget {
  final String imageUrl;
  final Double price;
  final String description;
  final String address;
  final String seller_name;
  final String property_type;
  final String property_ID ;
  final transaction_history;
  final Listing listing;

  PropertyDetailsPage({
    required this.imageUrl,
    required this.address,
    required this.description,
    required this.price,
    required this.listing, required OwnedProperties OwnedProperties, required ListedProperties ListedProperties, required Listings, required this.seller_name, required this.property_type, required this.property_ID, this.transaction_history,
  });

  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  bool _isBuying = false;
  bool _isMakingOffer = false;

   int _selectedIndex = 0;


  void _onItemTapped(int index) {
    if (index == 0) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );

  } else  if (index == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritePage()),
    );
  } else if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddListingPage()),
    );

    } else {
    setState(() {
      _selectedIndex = index;
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),

            ListTile(
              title: Text('My properties'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PropertiesOwnedPage()),
                );
              },
            ),
            ListTile(
              title: Text('My listings'),
              onTap: () {
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => PropertiesOwnedPage()),
                );
                
              },
            ),
            ListTile(
              title: Text('My listings'),
              onTap: () {
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => PropertiesOwnedPage()),
                );
                
              },
            ),
            ListTile(
              title: Text('My listings'),
              onTap: () {
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => PropertiesOwnedPage()),
                );
                
              },
            ),
            ListTile(
              title: Text('My profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      name: '',
                      email: '',
                      address: '',
                      phoneNumber: '', ID_number: '', IDnumber: '',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add listing',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(widget.address),
                  SizedBox(height: 20.0),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(widget.description),
                  SizedBox(height: 20.0),
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text('\$${widget.price}'),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _isBuying ? null : () => _buyProperty(context),
                        child: Text('Make payment'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buyProperty(BuildContext context) {
    setState(() {
      _isBuying = true;
    });
    // TODO: Implement logic for buying the property
  }

  void _makeOffer(BuildContext context) {
    setState(() {
      _isMakingOffer = true;
    });
    // TODO: Implement logic for making an offer on the property
  }
}
