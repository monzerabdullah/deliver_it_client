import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/views/orders_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeliveredOrders extends StatefulWidget {
  const DeliveredOrders({super.key});

  @override
  State<DeliveredOrders> createState() => _DeliveredOrdersState();
}

class _DeliveredOrdersState extends State<DeliveredOrders> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('store_id', isEqualTo: user?.uid)
          .where('status', isEqualTo: 'delivered')
          .snapshots(),
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
