import 'package:flutter/material.dart';
import 'package:test/home_page.dart';
import 'saved.dart';
import 'Listings.dart';
import 'package:test/edit_profile.dart';
import 'package:test/add_listing.dart';
import 'properties_owned.dart';
import 'wallet.dart';
import 'package:test/smart_contract_link.dart';
import 'edit_profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String ID_number;

  ProfilePage({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.ID_number, required String IDnumber,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class EditProfilePage extends StatelessWidget {
  final dynamic user;  // Changed from 'User' to 'dynamic'

  EditProfilePage({this.user});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // Rest of the EditProfilePage code...
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 2) {
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
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage(user: null,)),
              );
            },
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
                      phoneNumber: '',
                      ID_number: '', 
                      IDnumber: '',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.name,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Email',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.email,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Phone Number',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.phoneNumber,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'ID number',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            
          ],
        ),
      ),
    );
  }
}


