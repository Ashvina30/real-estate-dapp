import 'package:flutter/material.dart';
import 'package:test/firebase_auth.dart';
import 'package:test/smart_contract_link.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _identityNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSignupButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // Perform sign up logic here
      // ...
    
      // Navigate to the onboarding pages after successful sign up
      Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<Smart_Contract_Link>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                validator: (value) => value!.isEmpty ? 'Name can\'t be empty' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _identityNoController,
                decoration: InputDecoration(
                  hintText: 'Identity No',
                ),
                validator: (value) => value!.isEmpty ? 'Identity No can\'t be empty' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                ),
                validator: (value) => value!.isEmpty ? 'Address can\'t be empty' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Password can\'t be empty' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSignupButtonPressed,
                child: Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
