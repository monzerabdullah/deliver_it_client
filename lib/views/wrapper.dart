import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/main.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:deliver_it_client/views/authenticate.dart';
import 'package:deliver_it_client/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}


// 
        