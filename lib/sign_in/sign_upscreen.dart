

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinetest1/sign_in/sign_inscreen.dart';

import '../services/auth_service.dart';
import '../utils/common_utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _role;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _authService.signUpWithEmail(_email!, _password!, _role!, context);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => CommonUtils.validateEmail(value),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => CommonUtils.validateNotEmpty(value, 'Password'),
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Role'),
                  items: ['admin', 'user']
                      .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  ))
                      .toList(),
                  validator: (value) => CommonUtils.validateNotEmpty(value, 'Role'),
                  onChanged: (value) {
                    _role = value;
                  },
                ),
                SizedBox(height: 32.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Text('Already have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
