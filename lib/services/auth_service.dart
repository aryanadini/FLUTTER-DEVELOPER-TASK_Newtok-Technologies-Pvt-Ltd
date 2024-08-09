import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../module/admin/admin_screen.dart';
import '../module/users/display_data.dart';
import '../sign_in/sign_inscreen.dart';
import '../utils/common_utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Handle Authentication and Role-based Routing
  Widget handleAuth() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
            future:
                _firestore.collection('users').doc(snapshot.data!.uid).get(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (roleSnapshot.hasError || !roleSnapshot.hasData) {
                return SafeArea(
                    child:
                        SignInScreen()); // Fallback to sign-in if error or no data
              }

              // Determine the user's role and navigate accordingly
              final userRole = roleSnapshot.data!.get('role');
              if (userRole == 'admin') {
                return SafeArea(child: AdminDashboardScreen());
              } else if (userRole == 'user') {
                return SafeArea(child: UserDashboardScreen());
              } else {
                return SafeArea(
                    child:
                        SignInScreen()); // Fallback if the role is not recognized
              }
            },
          );
        } else {
          return SafeArea(
              child:
                  SignInScreen()); // Show sign-in screen if user is not authenticated
        }
      },
    );
  }

  // Sign in with email and password
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      CommonUtils.showSnackBar(
          context, e.message ?? "An error occurred during sign-in");
    }
  }

  // Sign up with email and password
  Future<void> signUpWithEmail(
      String email, String password, String role, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Add user role to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,
      });
    } on FirebaseAuthException catch (e) {
      CommonUtils.showSnackBar(
          context, e.message ?? "An error occurred during sign-up");
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/sign_in');
    } catch (e) {
      CommonUtils.showSnackBar(context, "An error occurred during sign-out");
    }
  }
}
