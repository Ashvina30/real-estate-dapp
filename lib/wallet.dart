import 'package:flutter/material.dart';
import 'package:test/home_page.dart';
import 'Listings.dart';
import 'package:test/add_listing.dart';
import 'properties_owned.dart';
import 'package:test/saved.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';
class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double balance = 3500.0;

  List<Transaction> transactions = [];

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
        title: Text('Wallet'),
      ),
      body: Column(
        children: [
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
