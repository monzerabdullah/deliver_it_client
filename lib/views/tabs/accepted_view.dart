import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/firestore_service.dart';
import 'package:deliver_it_client/views/orders_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AcceptedOrders extends StatefulWidget {
  const AcceptedOrders({super.key});

  @override
  State<AcceptedOrders> createState() => _AcceptedOrdersState();
}

class _AcceptedOrdersState extends State<AcceptedOrders> {
  final user = FirebaseAuth.instance.currentUser;
  final FirestoreService _firestore = locator<FirestoreService>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore.acceptedOrders(user!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Column(
              children: [
                Text('data'),
              ],
            ),
          );
        }
        final orders = snapshot.data!.docs;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrdersItem(
                orderId: order.id,
              );
            },
          ),
        );
      },
    );
  }
}
