import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/models/order_model.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:deliver_it_client/services/firestore_service.dart';
import 'package:deliver_it_client/widgets/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = locator<FirestoreService>();
  final String _orderStatus = 'none';

  Color _getButtonColor() {
    switch (_orderStatus) {
      case 'waiting':
        return Colors.yellow;
      case 'accepted':
        return Colors.green;
      case 'shipping':
        return Colors.blue;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('store_id', isEqualTo: user?.uid)
                  .where('status', isEqualTo: 'accepted')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                // Check if snapshot has data
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text(
                          'لا توجد طلبات حتى الان',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            color: kPrimaryText,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  );
                }

                final orders = snapshot.data!.docs;

                // Check if there are no orders
                if (orders.isEmpty) {
                  return const SliverToBoxAdapter(
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
                  );
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.75, // Adjust as needed
                  ),
                  // padding: const EdgeInsets.all(10),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final order = orders[index];
                      return AcceptedOrderCard(order: order);
                    },
                    childCount: orders.length,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: OrderButton(
                onTap: () {
                  _firestore.createOrder(user);
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: Card(
                color: kPrimaryText,
                child: ListTile(
                  title: Text(
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
                      CircleAvatar(
                        backgroundColor: kPrimary,
                        child: Icon(
                          Icons.add,
                          color: kWhite,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: kWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
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
        ),
      ),
    );
  }
}

class AcceptedOrderCard extends StatelessWidget {
  final QueryDocumentSnapshot order;

  const AcceptedOrderCard({super.key, required this.order});

  Future<DocumentSnapshot> _getRiderData(String riderId) {
    return FirebaseFirestore.instance.collection('riders').doc(riderId).get();
  }

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
        // return Card(
        //   child: ListTile(
        //     title: const Text('Order Details:}'),
        //     subtitle: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text('created_at: ${order['created_at']}'),
        //         // Displaying rider data
        //       ],
        //     ),
        //   ),
        // );

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
                // const SizedBox(
                //   height: 8,
                // ),
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.more_horiz,
                        color: kPrimary,
                      )
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/imgs/e.jpg'),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'مزمل بشرى',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryText,
                  ),
                ),
                const Text(
                  'على بعد 10 دقائق منك',
                  // ' created_at: ${order['created_at'].toString()}',
                  style: TextStyle(
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
