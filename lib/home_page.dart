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
import 'package:web3dart/web3dart.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';

class Listing {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  Listing({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price, required String propertyType,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    'All',
    'Villas',
    'Houses',
    'Residential Land',
    'Wasteland',
    'Beach Houses'
  ];

  int _selectedIndex = 0;

  List<Listing> _listings = []; // Initialize an empty _listings list

  void _onItemTapped(int index) {
    if (index == 2) {
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

  void addListing(Listing listing) {
    setState(() {
      _listings.add(listing);
    });
  }
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Username'),
      ),
      body: Column(
        children: [
          Container(
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                                      builder: (context) => PropertyDetailsPage(
                                        listing: Listing(
                                          imageUrl: listing.imageUrl,
                                          title: listing.title,
                                          description: listing.description,
                                          price: listing.price, propertyType: '', id: ''
                                        ), address: '', description: '', imageUrl: '', price: 0.0, history: null, property_ID: '', property_type: '', seller_name: '',
                                    ),
                                    ),
                                  );
                                },
                                child: const Text('View details'),
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
          ),
        ],
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
    );
  }
}
