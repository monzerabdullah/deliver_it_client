import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/firestore_service.dart';
import 'package:deliver_it_client/views/details_view.dart';
import 'package:deliver_it_client/views/tabs/accepted_view.dart';
import 'package:deliver_it_client/views/tabs/all_view.dart';
import 'package:deliver_it_client/views/tabs/canceled_view.dart';
import 'package:deliver_it_client/views/tabs/delivered_view.dart';
import 'package:deliver_it_client/views/tabs/delivering_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: kWhite,
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

  final FirestoreService _firestore = locator<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.orderWithId(orderId),
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
                  TripPath(
                    orderId: order.id,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (order['status'] == 'pending') ...[
                        Container()
                      ] else if (order['status'] != 'ready_to_start') ...[
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                order['rider_avatar'],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              order['rider_name'],
                              style: kTextRegular16,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //rider_phone
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor: kPrimary,
                                child: Icon(
                                  Icons.call,
                                  color: kWhite,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const CircleAvatar(
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
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _firestore.confirmTrip(order.id);
                            },
                            style: kMainButton,
                            child: const Text(
                              'تأكيد',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: kWhite,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsView(orderId: order.id),
                                ),
                              );
                            },
                            style: kSecondaryButton,
                            child: const Text(
                              'التفاصيل',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: kPrimary,
                              ),
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

class TripPath extends StatelessWidget {
  TripPath({
    super.key,
    required this.orderId,
  });
  final String orderId;
  final FirestoreService _firestore = locator<FirestoreService>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _firestore.orderWithId(orderId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          final order = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['location'],
                      style: kTextRegular16,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      order['created_at'].toDate().toString(),
                      style: kTextRegular16,
                    )
                  ],
                ),
              ),
              const Expanded(
                child: Icon(
                  Icons.arrow_forward,
                  size: 32,
                  color: kPrimaryText,
                ),
              ),
              const Expanded(
                child: Text(
                  'لم يتم تحديد الوجهة بعد',
                  style: kTextRegular14,
                ),
              ),
            ],
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
          style: kTextRegular16,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          '22 يونيو ، 2024 ،  PM 8:04',
          style: kTextRegular16,
        )
      ],
    );
  }
}
