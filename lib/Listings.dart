import 'package:flutter/material.dart';
import 'package:test/Listings.dart';
import 'package:test/add_listing.dart';
import 'package:test/view_details.dart';
import 'package:test/wallet.dart';
import 'package:test/view_profile.dart';
import 'package:test/properties_owned.dart';
import 'signup.dart';
import 'saved.dart';
import 'Offers_received.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart'; // Import the provider package

class ListedProperties {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String id;

  ListedProperties({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.id,
  });
}

class ListedPropertiesPage extends StatefulWidget {
  const ListedPropertiesPage({Key? key, required String description, required List offers, required price}) : super(key: key); // Removed the unused parameters

  @override
  _ListedPropertiesPageState createState() => _ListedPropertiesPageState();
}

class _ListedPropertiesPageState extends State<ListedPropertiesPage> {
  int _selectedIndex = 0;
  get properties => null;

  // Make the list empty
  final List<ListedProperties> _listings = [];

  // Method to add new property
  void addProperty(ListedProperties property) {
    setState(() {
      _listings.add(property);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
        return Scaffold(
      appBar: AppBar(
        title: const Text('Username'),
      ),
      body: ListView.builder(
        itemCount: _listings.length,
        itemBuilder: (BuildContext context, int index) {
          final listing = _listings[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Image.network(listing.imageUrl),
                  ListTile(
                    title: Text(listing.title),
                    subtitle: Text(listing.description),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listing.price,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OffersReceivedPage(
                                  property: listing, ListedProperties: null, description: '', imageUrl: '', address: '', image: '', ownerName: '', price: '', // use the instance of the class 
                                ),
                              ),
                            );
                          },
                          child: const Text('View offers'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
                  context, MaterialPageRoute(builder: (context) => PropertiesOwnedPage()),
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
              title: Text('Sign Out'),
              onTap: () {
                // implement the sign out functionality
              },
            ),
          ],
        ),
      ),

    );
  }

}

