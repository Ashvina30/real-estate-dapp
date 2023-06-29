import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/smart_contract_link.dart';
import 'makeOffer.dart';
import 'view_profile.dart';
import 'wallet.dart';
import 'Listings.dart';
import 'properties_owned.dart';

/*class OffersSent {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String offerStatus;

  OffersSent({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.offerStatus,
  });
}*/

class ListingPage extends StatefulWidget {
  final List<OffersSent> listings;

  const ListingPage({Key? key, required this.listings}) : super(key: key);

  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        itemCount: widget.listings.length,
        itemBuilder: (BuildContext context, int index) {
          final listing = widget.listings[index];
          return Card(
            margin: EdgeInsets.all(8.0),
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
                        'Price: ${listing.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Status: ${listing.offerStatus}',
                        style: TextStyle(
                          fontSize: 20,
                          color: listing.offerStatus == 'Accepted' ? Colors.green : Colors.red,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {}, // Push navigation will be done here
                        child: const Text('View Details'),
                      ),
                    ],
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
        },
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
