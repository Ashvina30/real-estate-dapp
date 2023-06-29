  // Import necessary Flutter and custom packages
import 'package:flutter/material.dart';
import 'package:test/home_page.dart';
import 'Listings.dart';
import 'package:test/add_listing.dart';
import 'properties_owned.dart';
import 'package:test/saved.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';
import 'view_profile.dart';

// This is the main wallet page that is stateful as it can update over time
class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

// This is the state class that goes with WalletPage. It includes fields and methods that define the widget’s behavior
class _WalletPageState extends State<WalletPage> {
  // Variable to hold the current balance value
  double balance = 3500.0;

  // A list to store all the transactions made
  List<Transaction> transactions = [];

  // Variable to store the current selected index for the bottom navigation bar
  int _selectedIndex = 0;

  // This method is triggered when a navigation bar item is selected. It uses a switch statement to navigate to the appropriate page based on the selected index.
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

  // The build method of this widget. It describes the part of the user interface represented by the widget.
  @override
  Widget build(BuildContext context) {
    // Using Provider to access smart contract link
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      // The body of this page contains a column of widgets, including a container displaying balance and a list view builder to generate a list of transactions.
      body: Column(
        children: [
          // This container widget displays the current balance
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // This expanded widget includes a list view builder to create a dynamic list of transaction entries.
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                Transaction transaction = transactions[index];
                return ListTile(
                  leading: transaction.type == 'Credit'
                      ? Icon(Icons.arrow_circle_up, color: Colors.green)
                      : Icon(Icons.arrow_circle_down, color: Colors.purple),
                  title: Text('${transaction.type} - ${transaction.propertyID}'),
                  subtitle: Text(transaction.date),
                  trailing: Text(
                    '${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,            
                      color: transaction.type == 'Credit' ? Colors.green : Colors.purple,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // The bottom navigation bar of the app. Handles navigation between different pages of the app
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
      // The navigation drawer of the app. It contains links to other pages
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // The header section of the drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The user's avatar
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 16),
                  // The user's username
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  // The user's email address
                  Text(
                    'user@email.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // A list tile leading to the WalletPage
            ListTile(
              title: Text('My Wallet'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),
            // A list tile leading to the PropertiesOwnedPage
            ListTile(
              title: Text('My properties'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const PropertiesOwnedPage()),
                );
              },
            ),
            // A list tile leading to the ListedPropertiesPage
            ListTile(
              title: Text('My listings'),
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ListedPropertiesPage(description: '', offers: [], price: null,)),
                );
              },
            ),
            // A list tile leading to the ProfilePage
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

// The Transaction class. Represents a single transaction and includes necessary details such as type, amount, date, etc.
class Transaction {
  final String type;
  final double amount;
  final String date;
  final String propertyID;
  final String receiverName;
  final String senderName;

  Transaction({
    required this.type,
    required this.amount,
    required this.date,
    required this.propertyID,
    required this.receiverName,
    required this.senderName
  });
}
