import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/models/store.dart';
import 'package:deliver_it_client/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestore = locator<FirestoreService>();
  late Store _currentStore;

  Store get currentStore => _currentStore;
  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await populateCurrentStore(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future signUpWithEmail({
    required String email,
    required String password,
    required String storeName,
    required String storeLogoUrl,
    required String storePhone,
    required String ownerFullName,
    required String location,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentStore = Store(
          id: authResult.user!.uid,
          storeName: storeName,
          storeLogoUrl: storeLogoUrl,
          storePhone: storePhone,
          ownerFullName: ownerFullName,
          location: location);
      await _firestore.createStore(_currentStore);
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

  Future populateCurrentStore(User? user) async {
    if (user != null) {
      _currentStore = await _firestore.getStore(user.uid);
    }
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
