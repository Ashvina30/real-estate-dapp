import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'smart_contract_link.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }
}

class AuthService {
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign up with email, name, ID number, phone number, address, and password
  Future<String?> signUpWithEmailAndPassword(
      String email,
      String name,
      String idNumber,
      String phoneNumber,
      String address,
      String password) async {
    try {
      fb_auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fb_auth.User firebaseUser = result.user!;
      await _db.collection('users').doc(firebaseUser.uid).set(
        User(
          id: firebaseUser.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
        ).toMap(),
      );
      return firebaseUser.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Log in with email and password
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      fb_auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fb_auth.User firebaseUser = result.user!;
      return firebaseUser.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

// Upload a picture to Firebase Storage and return the URL
Future<String?> uploadPicture(File picture) async {
  try {
    String filename = Uuid().v1(); 
    Reference ref = FirebaseStorage.instance.ref().child('pictures/$filename');
    UploadTask uploadTask = ref.putFile(picture);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
