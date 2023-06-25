import 'package:flutter/material.dart';
import 'home_page.dart' hide Listing;
import 'add_listing.dart' hide Listing;
import 'properties_owned.dart';
import 'view_profile.dart';
import 'Listings.dart' ;
import 'wallet.dart';
import 'package:test/smart_contract_link.dart';
import 'view_details.dart';
import 'package:provider/provider.dart';
import 'firebase_auth.dart';

class Listing {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  Listing({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Listing> _favoriteProperties = []; // Initiate an empty list

  int _selectedIndex = 2;

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
        title: Text('My Favorites'),
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
                  MaterialPageRoute(
                    builder: (context) => ListedPropertiesPage(
                      description: '',
                      offers: [],
                      price: null,
                    ),
                  ),
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
      body: ListView.builder(
        itemCount: _favoriteProperties.length,
        itemBuilder: (BuildContext context, int index) {
          final property = _favoriteProperties[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Image.network(property.imageUrl),
                  ListTile(
                    title: Text(property.title),
                    subtitle: Text(property.description),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.price,
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
                                    imageUrl: property.imageUrl,
                                    title: property.title,
                                    description: property.description,
                                    price: property.price
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
    );
  }
}




