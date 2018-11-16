import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ipptbuddy/controllers/home_controller.dart';

// abstract class which holds all function to autentication logic
abstract class BaseAuth {
  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
}

// Controller class which holds all function to authentication logic
class Auth implements BaseAuth {
  // Classes used
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  // Store id to shared preferences
  void storeLocal(String email) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', email);
  }

  // Function to call authentication backend to sign in
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    storeLocal(email);
    return user.uid;
  }

  // Function to call authentication backend to create account
  Future<String> createUser(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    storeLocal(email);
    HomeController.updateAccount(email);
    return user.uid;
  }

  // Function to call authentication backend to get current user details
  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  // Function to call authentication backend to sign out
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
