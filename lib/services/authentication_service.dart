import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      // return e.toString();
      print(e.toString());
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> userIsLoggedIn() async {
    var result = _firebaseAuth.currentUser;
    return result != null;
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
