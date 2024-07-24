import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/firestore_service.dart';
import 'package:deliver_it_client/services/notification_service.dart';
import 'package:deliver_it_client/widgets/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  late NotificationService _notificationService;

  final user = FirebaseAuth.instance.currentUser;
  final FirestoreService _firestore = locator<FirestoreService>();

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    // _notificationService.listenToFirestoreDocument('orders');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.activeOrders(user!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text(
                          'لا توجد طلبات حتى الان',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: kPrimaryText,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ],
              );
              // Check if snapshot has data
            }
            final orders = snapshot.data!.docs;
            // Check if there are no orders
            final pendingOrders = orders
                .where(
                  (order) => order['status'] == 'pending',
                )
                .length;
            var ordersCards = orders
                .where(
                  (order) => order['status'] != 'pending',
                )
                .toList();

            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 60,
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.75, // Adjust as needed
                  ),
                  // padding: const EdgeInsets.all(10),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final order = ordersCards[index];
                      return AcceptedOrderCard(order: order);
                    },
                    childCount: ordersCards.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: OrderButton(
                    onTap: () {
                      _firestore.createOrder(user);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    color: kPrimaryText,
                    child: ListTile(
                      title: const Text(
                        'عدد الطلبات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: kWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: kPrimary,
                            child: Icon(
                              Icons.add,
                              color: kWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            pendingOrders.toString(),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: kWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const CircleAvatar(
                            backgroundColor: kPrimary,
                            child: Icon(
                              Icons.remove,
                              color: kWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AcceptedOrderCard extends StatelessWidget {
  final QueryDocumentSnapshot order;

  AcceptedOrderCard({super.key, required this.order});

  Future<DocumentSnapshot> _getRiderData(String riderId) {
    return FirebaseFirestore.instance.collection('riders').doc(riderId).get();
  }

  String orderLabel(String orderStatus) {
    if (orderStatus == 'accepted') {
      return 'على بعد 10 دقائق منك';
    } else if (orderStatus == 'ready_to_start') {
      return 'جاهز لبدء الرحلة';
    } else if (orderStatus == 'delivering') {
      return 'يوصل الطلب';
    } else {
      return 'غير محدد';
    }
  }

  final FirestoreService _firestore = locator<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRiderData(order['rider_id']),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // Check if snapshot has data
        if (!snapshot.hasData) {
          return const Card(
            child: ListTile(
              title: Text('Loading rider info...'),
            ),
          );
        }

        final riderData = snapshot.data!;

        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 230,
            width: 165.91,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    PopupMenuButton(
                      color: kWhite,
                      icon: const Icon(Icons.more_horiz),
                      iconColor: kPrimary,
                      itemBuilder: (context) => [
                        if (order['status'] == 'ready_to_start') ...[
                          PopupMenuItem(
                            value: 'تأكيد',
                            child: const Text(
                              'تأكيد',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.0,
                              ),
                            ),
                            onTap: () {
                              _firestore.confirmTrip(order.id);
                            },
                          ),
                          PopupMenuItem(
                            value: 'إلغاء الرحلة',
                            child: const Text(
                              'إلغاء الرحلة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.0,
                              ),
                            ),
                            onTap: () {
                              _firestore.cancelOrder(order.id);
                            },
                          ),
                          const PopupMenuItem(
                            value: 'طلب مرة أخرى',
                            child: Text(
                              'طلب مرة أخرى',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                        if (order['status'] != 'ready_to_start') ...[
                          PopupMenuItem(
                            value: 'إلغاء الرحلة',
                            child: const Text(
                              'إلغاء الرحلة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.0,
                              ),
                            ),
                            onTap: () {
                              _firestore.cancelOrder(order.id);
                            },
                          ),
                          const PopupMenuItem(
                            value: 'طلب مرة أخرى',
                            child: Text(
                              'طلب مرة أخرى',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ]
                      ],
                    )
                  ],
                ),
                const CircleAvatar(
                  radius: 42,
                  backgroundImage: AssetImage('images/imgs/e.jpg'),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'مزمل بشرى',
                  style: kTextMedium16,
                ),
                Text(
                  orderLabel(order['status']),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryText,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          launchUrlString('tel://01146784805');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          color: kPrimary,
                          child: const Text(
                            'إتصال',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.0,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: kPrimary.withOpacity(.3),
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'تتبع',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16.0,
                            color: kPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StoreReviewTripScreen extends StatelessWidget {
  const StoreReviewTripScreen({super.key, required this.payload});
  final String payload;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/imgs/e.jpg'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'تم التوصيل!!',
                    textAlign: TextAlign.center,
                    style: kTextBold32,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_outline,
                        size: 42,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.star,
                        size: 42,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        size: 42,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        size: 42,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        size: 42,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'قم بتقييم تجرتك مع هذا المندوب ، ما الذي أعجبك ، ما الذي بجب تحسينه والإهتمام به',
                    textAlign: TextAlign.center,
                    style: kTextRegular16,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: kMainButton,
                    onPressed: () {
                      //show dialog here
                    },
                    child: const Text(
                      'أكتب تقيما',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: kSecondaryButton,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'لا أريد',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
