import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/details_view.dart';
import 'package:deliver_it_client/views/tabs/accepted_view.dart';
import 'package:deliver_it_client/views/tabs/all_view.dart';
import 'package:deliver_it_client/views/tabs/canceled_view.dart';
import 'package:deliver_it_client/views/tabs/delivered_view.dart';
import 'package:deliver_it_client/views/tabs/delivering_view.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWhite,
          toolbarHeight: 10,
          bottom: const TabBar(
            indicatorColor: kPrimary,
            tabs: [
              Tab(
                child: Text('الكل'),
              ),
              Tab(
                child: Text('تم القبول'),
              ),
              Tab(
                child: Text('جاري'),
              ),
              Tab(
                child: Text('وصلت'),
              ),
              Tab(
                child: Text('ملغية'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllOrders(),
            AcceptedOrders(),
            DeliveringOrders(),
            DeliveredOrders(),
            CanceledOrders(),
          ],
        ),
      ),
    );
  }
}

class OrdersItem extends StatelessWidget {
  OrdersItem({super.key, required this.orderId});
  final String orderId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String chaipLabel(String orderStatus) {
    if (orderStatus == 'pending') {
      return 'في إنتظار القبول';
    } else if (orderStatus == 'accepted') {
      return 'تم القبول';
    } else if (orderStatus == 'ready_to_start') {
      return 'جاهز للتوصيل';
    } else if (orderStatus == 'delivering') {
      return 'جاري للتوصيل';
    } else if (orderStatus == 'canceled') {
      return 'ملغية';
    } else if (orderStatus == 'delivered') {
      return 'تم التوصيل';
    } else {
      return 'غير محدد';
    }
  }

  WidgetStatePropertyAll<Color?> chipColor(String orderStatus) {
    if (orderStatus == 'pending') {
      return const WidgetStatePropertyAll(kPrimary);
    } else if (orderStatus == 'accepted') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'ready_to_start') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'delivering') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'delivered') {
      return const WidgetStatePropertyAll(kSecondary);
    } else if (orderStatus == 'canceled') {
      return const WidgetStatePropertyAll(kRed);
    } else {
      return const WidgetStatePropertyAll(kPrimary);
    }
  }

  void _confirmTrip(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'delivering',
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('orders').doc(orderId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final order = snapshot.data!;
          return Card(
            color: kWhite,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        color: chipColor(order.get('status')),
                        label: Text(
                          chaipLabel(order.get('status')),
                          style: const TextStyle(
                            color: kWhite,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      Text(
                        order.id,
                        style: const TextStyle(
                          color: kPrimaryText,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: LocationSide()),
                      Expanded(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 32,
                          color: kPrimaryText,
                        ),
                      ),
                      Expanded(child: LocationSide()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (order['status'] != 'ready_to_start') ...[
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                'images/imgs/e.jpg',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'مزمل بشرى',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kPrimary,
                              child: Icon(
                                Icons.call,
                                color: kWhite,
                              ),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kPrimary,
                              child: Icon(
                                Icons.location_pin,
                                color: kWhite,
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         DetailsView(orderId: order.id),
                            //   ),
                            // );
                            _confirmTrip(order.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'تأكيد',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: kWhite,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsView(orderId: order.id),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: kPrimary,
                              ),
                            ),
                          ),
                          child: const Text(
                            'التفاصيل',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: kPrimary,
                            ),
                          ),
                        ),
                      ]
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class LocationSide extends StatelessWidget {
  const LocationSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أكتوبر الحي التاني',
          style: TextStyle(
            color: kPrimaryText,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          '22 يونيو ، 2024 ،  PM 8:04',
          style: TextStyle(
            color: kSecondaryText,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
