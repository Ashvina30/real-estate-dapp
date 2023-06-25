import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/smart_contract_link.dart' hide User;
import 'package:test/add_listing.dart';
import 'saved.dart';
import 'home_page.dart';
import 'Listings.dart';
import 'package:test/payment_successful.dart';
import 'package:test/properties_owned.dart';
import 'package:test/purchase_overview.dart';
import 'package:test/wallet.dart';
import 'package:test/view_profile.dart' hide EditProfilePage;
import 'edit_profile.dart';
import 'firebase_auth.dart';




void main() {
  runApp(
    MultiProvider(
      providers: [
    ChangeNotifierProvider(
      create: (context) => Smart_Contract_Link()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      //Provider(create: (context) => SomeOtherClass()),
      ],
      //
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate DApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/addListing':
            return MaterialPageRoute(builder: (context) => AddListingPage());
          case '/favorite':
            return MaterialPageRoute(builder: (context) => FavoritePage());
          case '/listedProperties':
            final ListedPropertiesPageArgs args = settings.arguments as ListedPropertiesPageArgs;
            return MaterialPageRoute(
              builder: (context) => ListedPropertiesPage(
                description: args.description,
                offers: args.offers,
                price: args.price,
              ),
            );
          case '/purchaseOverview':
            final PurchaseOverviewPageArgs args = settings.arguments as PurchaseOverviewPageArgs;
            return MaterialPageRoute(
              builder: (context) => PurchaseOverviewPage(
                propertyID: args.propertyID,
                propertyTitle: args.propertyTitle,
                price: args.price,
                tax: args.tax, imagePath: '', ownerID: '', ownerName: '', priceOffered: 0.0,
              ),
            );
            case '/profile':
  final ProfilePageArgs args = settings.arguments as ProfilePageArgs;
  return MaterialPageRoute(
    builder: (context) => ProfilePage(
      name: args.name,
      email: args.email,
      phoneNumber: args.phoneNumber,
      ID_number: '',  // <- this is currently an empty string
      address: '',    // <- this is currently an empty string
      IDnumber: '',   // <- this is currently an empty string
    ),
  );

          case '/paymentSuccessful':
            final PaymentSuccessfulPageArgs args = settings.arguments as PaymentSuccessfulPageArgs;
            return MaterialPageRoute(
              builder: (context) => PaymentSuccessfulPage(
                amount: args.amount,
                paymentMethod: args.paymentMethod,
                transactionID: args.transactionID, ownerName: '', pricePaid: '', propertyID: '', taxPaid: 0.0,
              ),
            );
            case '/editProfile':
  final EditProfilePageArgs args = settings.arguments as EditProfilePageArgs;
  return MaterialPageRoute(
    builder: (context) => EditProfilePage(user: args.user),
  );

          case '/propertiesOwned':
            return MaterialPageRoute(builder: (context) => PropertiesOwnedPage());
          case '/wallet':
            return MaterialPageRoute(builder: (context) => WalletPage());
          case '/profile':
            final ProfilePageArgs args = settings.arguments as ProfilePageArgs;
            return MaterialPageRoute(
              builder: (context) => ProfilePage(
                name: args.name,
                email: args.email,
                phoneNumber: args.phoneNumber, ID_number: '', address: '', IDnumber: '',
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}

class EditProfilePageArgs {
  final User user;

  EditProfilePageArgs({required this.user});
}

// Argument Classes

class HomePageArgs {
  // Add any relevant arguments for HomePage
}

class AddListingPageArgs {
  // Add any relevant arguments for AddListingPage
}

class FavoritePageArgs {
  // Add any relevant arguments for FavoritePage
}

class ListedPropertiesPageArgs {
  final String description;
  final List<String> offers;
  final double? price;

  ListedPropertiesPageArgs({
    required this.description,
    required this.offers,
    required this.price,
  });
}

class PurchaseOverviewPageArgs {
  final String propertyID;
  final String propertyTitle;
  final double price;
  final double tax;

  PurchaseOverviewPageArgs({
    required this.propertyID,
    required this.propertyTitle,
    required this.price,
    required this.tax,
  });
}

class PaymentSuccessfulPageArgs {
  final double amount;
  final String paymentMethod;
  final String transactionID;

  PaymentSuccessfulPageArgs({
    required this.amount,
    required this.paymentMethod,
    required this.transactionID,
  });
}

class PropertiesOwnedPageArgs {
  // Add any relevant arguments for PropertiesOwnedPage
}

class WalletPageArgs {
  // Add any relevant arguments for WalletPage
}

class ProfilePageArgs {
  final String name;
  final String email;
  final String phoneNumber;

  ProfilePageArgs({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
