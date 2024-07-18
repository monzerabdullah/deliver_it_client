import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/models/order_model.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:deliver_it_client/services/firestore_service.dart';
import 'package:deliver_it_client/widgets/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = locator<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              await AuthenticationService().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ),
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              OrderButton(
                onTap: () async {
                  _firestore.createOrder(_auth.currentUser);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
