import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';



class Listing {
  final String id;
  final String title;
  final String description;
  final double price;
  final String address;
  final String propertyType;
  final String imageUrl;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.address,
    required this.propertyType,
    required this.imageUrl,
  });
}
class AddListingPage extends StatefulWidget {
  @override
  _AddListingPageState createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  String _propertyType = 'Residential';
  File? _image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
      setState(() {
        _image = savedImage;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _addListing() async {
    await _firestore.collection('listings').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
      'address': _addressController.text,
      'id': _idController.text,
      'propertyType': _propertyType,
      'imagePath': _image!.path,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Listing'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload an Image',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _image == null
                  ? ElevatedButton(
                      onPressed: () => _getImage(ImageSource.gallery),
                      child: Text('Select an Image'),
                    )
                  : Column(
                      children: [
                        Image.file(_image!),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () => _getImage(ImageSource.gallery),
                          child: Text('Change Image'),
                        ),
                      ],
                    ),
SizedBox(height: 20.0),
Text(
  'Title',
  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 10.0),
TextField(
  controller: _titleController,
  decoration: InputDecoration(
    hintText: 'Enter a title for your listing',
    border: OutlineInputBorder(),
  ),
),
SizedBox(height: 20.0),
Text(
  'Description',
  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 10.0),
TextField(
  controller: _descriptionController,
  maxLines: 5,
  decoration: InputDecoration(
    hintText: 'Enter a description for your listing',
    border: OutlineInputBorder(),
  ),
),
SizedBox(height: 20.0),
Text(
  'Price',
  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 10.0),
TextField(
  controller: _priceController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    hintText: 'Enter a price for your listing',
    border: OutlineInputBorder(),
  ),
),
SizedBox(height: 20.0),
Text(
  'Address',
  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 10.0),
TextField(
  controller: _addressController,
  decoration: InputDecoration(
    hintText: 'Enter the property address',
    border: OutlineInputBorder(),
  ),
),
SizedBox(height: 20.0),
Text(
  'Property ID',
  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 10.0),
TextField(
  controller: _idController,
  decoration: InputDecoration(
    hintText: 'Enter a unique ID for this property',
    border: OutlineInputBorder(),
  ),
),
SizedBox(height: 20.0),
Text(
  'Property Type',
  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 10.0),
DropdownButton<String>(
  value: _propertyType,
  items: <String>['Residential', 'Commercial', 'Land']
      .map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (newValue) {
    setState(() {
      _propertyType = newValue!;
    });
  },
),
SizedBox(height: 20.0),
ElevatedButton(
  onPressed: _submitListing,
  child: Text('Add to listings'),
),
],
),
),
),
);
}

Future<void> _submitListing() async {
if (_image == null ||
    _titleController.text.isEmpty ||
    _descriptionController.text.isEmpty ||
    _priceController.text.isEmpty ||
    _addressController.text.isEmpty ||
    _idController.text.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Please fill in all fields and upload an image.')),
);
return;
}
Future<String> _uploadImage() async {
  // Ensure that an image file is selected
  if (_image == null) {
    throw Exception('No image file selected');
  }

  // Use the filename extension to infer the file type
  final String fileType = path.extension(_image!.path);

  // Create a reference to the location you want to upload to in Firebase Storage
  final storageReference = FirebaseStorage.instance
      .ref()
      .child('listings/${_idController.text}$fileType');

  // Upload the file to Firebase Storage
  final uploadTask = storageReference.putFile(_image!);

  // Wait until the file is uploaded then retrieve its download URL
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
  final String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}

String imageUrl;
try {
  imageUrl = await _uploadImage();
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Image upload failed. Please try again.')),
  );
  return;
}

final listing = Listing(
  id: _idController.text,
  title: _titleController.text,
  description: _descriptionController.text,
  price: double.parse(_priceController.text),
  address: _addressController.text,
  propertyType: _propertyType,
  imageUrl: imageUrl,
);

try {
  // TODO: Submit the listing data to Ethereum smart contract.
  // This is where you'd call your function to submit the listing to the blockchain.
  // After the function has been called and the transaction is confirmed, you can continue to save the image and property ID in Firebase.
  Future<void> _uploadListing(Listing listing) async {
  await _firestore.collection('listings').add({
    'title': listing.title,
    'description': listing.description,
    'price': listing.price,
    'address': listing.address,
    'id': listing.id,
    'propertyType': listing.propertyType,
    'imageUrl': listing.imageUrl,
  });
}

  await _uploadListing(listing);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Listing uploaded successfully!')),
  );
  Navigator.pop(context);
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Listing upload failed. Please try again.')),
  );
}
}
}
