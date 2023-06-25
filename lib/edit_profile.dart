import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneNumberController = TextEditingController(text: widget.user.phoneNumber);
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: "Phone Number"),
          ),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(labelText: "Address"),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: Text('Update Profile'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    // Create an updated user
    User updatedUser = User(
      id: widget.user.id,
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
      address: _addressController.text,
    );

    // Push the updated user to Firebase
    _updateUserInFirebase(updatedUser);
  }

  void _updateUserInFirebase(User user) {
    FirebaseFirestore.instance
      .collection('users')
      .doc(user.id)
      .set(user.toMap())
      .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context);
      })
      .catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile')),
        );
      });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
