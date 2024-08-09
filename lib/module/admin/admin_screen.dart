import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../sign_in/sign_inscreen.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard',style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined,color: Colors.indigo,),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Sign out the user
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome, Admin!',style: TextStyle(color: Colors.black),),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Dashboard',style: TextStyle(color: Colors.black),),
              onTap: () {
                // Navigate to admin dashboard
              },
            ),
            ListTile(
              title: Text('Add Location',style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.pushNamed(context, '/admin/add_location');
              },
            ),
          ],
        ),
      ),
    );
  }
}
