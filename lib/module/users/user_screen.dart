import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../sign_in/sign_inscreen.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
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
        child: Text('Welcome, User!'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Navigate to user dashboard
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Upload Excel'),
              onTap: () {
                Navigator.pushNamed(context, '/user/upload_excel');
              },
            ),
            ListTile(
              title: Text('View Weather Report'),
              onTap: () {
                Navigator.pushNamed(context, '/user/weather_report');
              },
            ),
            ListTile(
              title: Text('View Locations'),
              onTap: () {
                Navigator.pushNamed(context, '/user/view_locations');
              },
            ),
          ],
        ),
      ),
    );
  }
}
