import 'dart:convert';
import 'package:flutter/services.dart';  // Needed for rootBundle
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
//import 'marketplace.sol';

class Smart_Contract_Link extends ChangeNotifier {
  List<Property> properties = [];
  List<User> users = [];
  UserCredential? user = FirebaseAuth.instance.currentUser as UserCredential?;

  final String _rpcUrl = "HTTP://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey = "fd2ed011ded3919b92bb5816415d077492215d5342e9079625edd87e53b83155";

  Web3Client? _client;

  String? _abiCode;
  EthereumAddress? _contractAddress;
  Credentials? _credentials;

  DeployedContract? _contract;
  ContractFunction? _addListing;
  ContractFunction? _viewListing;
  ContractFunction? _saveListing;
  ContractFunction? _chooseCategory;
  ContractFunction? _viewProfile;
  ContractFunction? _viewListedProperties;
  ContractFunction? _viewWallet;
  ContractFunction? _viewOwnedProperties;
  ContractFunction? _registerTransactions;
  ContractFunction? _viewPropertyDetails;
  ContractFunction? _makeOffer;
  ContractFunction? _acceptOffer;
  ContractFunction? _declineOffer;
  ContractFunction? _viewOffersReceived;
  ContractFunction? _viewOffersMade;
  ContractFunction? _addTransactionToHistory;
  ContractFunction? _propertyTransactions;
  ContractFunction? _changePropertyType;
  ContractFunction? _executePurchase;

  Smart_Contract_Link() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbis();
    await getCredentials();
    await getDeployedContract();
  }

  getAbis() async {
    String abiString = await rootBundle.loadString('src/abis/RealEstate.json');
    var jsonFile = json.decode(abiString);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress = EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }
  getCredentials() async {
    try {
      _credentials = await _client!.credentialsFromPrivateKey(_privateKey);
    } catch (e) {
      print('The private key is not in the correct format: $e');
    }
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "RealEstate"), _contractAddress!);

    _addListing = _contract!.function("_addListing");
    _viewListing = _contract!.function("_viewListing");
    _saveListing = _contract!.function("_saveListing");
    _chooseCategory = _contract!.function("_chooseCategory");
    _viewProfile = _contract!.function("_viewProfile");
    _viewListedProperties = _contract!.function("_viewListedProperties");
    _viewWallet = _contract!.function("_viewWallet");
    _viewOwnedProperties = _contract!.function("_viewOwnedProperties");
    _registerTransactions = _contract!.function("_registerTransactions");
    _viewPropertyDetails = _contract!.function("_viewPropertyDetails");
    _makeOffer = _contract!.function("_makeOffer");
    _acceptOffer = _contract!.function("_acceptOffer");
    _declineOffer = _contract!.function("_declineOffer");
    _viewOffersReceived = _contract!.function("_viewOffersReceived");
    _viewOffersMade = _contract!.function("_viewOffersMade");
    _addTransactionToHistory = _contract!.function("_addTransactionToHistory");
    _propertyTransactions = _contract!.function("_propertyTransactions");
    _changePropertyType = _contract!.function("_changePropertyType");
    _executePurchase = _contract!.function("executePurchase");
  }


   //function to execute purchase
    Future<void> executePurchase({
    required String propertyId,
    required double price,
    required double tax,
  }) async {
    try {
      final transactionResponse = await _client!.sendTransaction(
        _credentials!, 
        Transaction.callContract(
          contract: _contract!,
          function: _executePurchase!,
          parameters: [propertyId, BigInt.from(price), BigInt.from(tax)],
        ),
        fetchChainIdFromNetworkId: true,
      );

      print('Successfully executed purchase transaction.');
    } catch (e) {
      print('Failed to execute purchase transaction: $e');
      throw e;
    }

    notifyListeners();
  }



  // Add the methods to interact with the smart contract functions ...
}

class User {
  String name;
  String email;
  String phoneNumber;
  String password;
  List<String> propertiesOwned;
  List<int> listingsMade;
  List<int> transactions;
  int wallet;
  List<String> savedProperties;
  int idNumber;

  User(
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.propertiesOwned,
    this.listingsMade,
    this.transactions,
    this.wallet,
    this.savedProperties,
    this.idNumber,
  );
}

class Property {
  String propertyType;
  String photos;
  String currentOwner;
  int price;
  String propertyAddress;
  List<int> transactionHistory;

  Property(
    this.propertyType,
    this.photos,
    this.currentOwner,
    this.price,
    this.propertyAddress,
    this.transactionHistory,
  );

  
}
