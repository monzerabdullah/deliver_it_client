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
