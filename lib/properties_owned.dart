import 'package:flutter/material.dart';
import 'package:test/Listings.dart';
import 'package:test/add_listing.dart';
import 'package:test/view_details.dart';
import 'package:test/wallet.dart';
import 'package:test/view_profile.dart';
import 'signup.dart';
import 'saved.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';

class OwnedProperties {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  OwnedProperties({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });
}

class PropertiesOwnedPage extends StatefulWidget {
  const PropertiesOwnedPage({Key? key}) : super(key: key);

  @override
  _PropertiesOwnedPageState createState() => _PropertiesOwnedPageState();
}

class _PropertiesOwnedPageState extends State<PropertiesOwnedPage> {
  int _selectedIndex = 0;

  final List<OwnedProperties> ownedProperties = [];

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

  void addOwnedProperty(OwnedProperties property) {
    setState(() {
      ownedProperties.add(property);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
@override
Widget build(BuildContext context) {
  var contractLink = Provider.of<Smart_Contract_Link>(context);
  var ownedProperties;
  return Scaffold(
    appBar: AppBar(
      title: const Text('Username'),
    ),
    body: ListView.builder(
      itemCount: ownedProperties.length,
      itemBuilder: (BuildContext context, int index) {
        var ownedProperties;
        final property = ownedProperties[index];
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
                  child: Text(
                    property.price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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
                MaterialPageRoute(builder: (context) => ListedPropertiesPage(description: '', offers: [], price: null)),
              );
            },
          ),
          ListTile(
            title: Text('My profile'),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ProfilePage(name: '', email: '', address: '', phoneNumber: '', ID_number: '', IDnumber: '',)),
              );
            },
          ),
        ],
      ),
    ),
  );
}
