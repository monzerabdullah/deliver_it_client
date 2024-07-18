import 'package:deliver_it_client/views/login_view.dart';
import 'package:deliver_it_client/views/signup_view.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false;
  final String _role = 'store'; // or 'rider'

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? LoginView(
            toggleView: toggleView,
          )
        : SignUpView(
            toggleView: toggleView,
          );
  }
}





    // Store additional user data in Firestore
  //   FirebaseFirestore.instance
  //       .collection(role)
  //       .doc(userCredential.user!.uid)
  //       .set({
  //     'email' = _email,
  //     'role' = _role,
  //   });
  // }

