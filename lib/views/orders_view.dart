import 'package:deliver_it_client/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection('orders')
    //       .where('store_id', isEqualTo: user?.uid)
    //       .where('status', isEqualTo: 'accepted')
    //       .snapshots(),
    //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     // Check if snapshot has data
    //     if (!snapshot.hasData) {
    //       return const SliverToBoxAdapter(
    //         child: Column(
    //           children: [
    //             Text(
    //               'لا توجد طلبات حتى الان',
    //               style: TextStyle(
    //                 fontFamily: 'Cairo',
    //                 fontSize: 16,
    //                 color: kPrimaryText,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 40,
    //             )
    //           ],
    //         ),
    //       );
    //     }

    //     final orders = snapshot.data!.docs;

    //     // Check if there are no orders
    //     if (orders.isEmpty) {
    //       return const SliverToBoxAdapter(
    //         child: Column(
    //           children: [
    //             Text(
    //               'لا توجد طلبات حتى الان',
    //               style: TextStyle(
    //                 fontFamily: 'Cairo',
    //                 color: kPrimaryText,
    //                 fontSize: 16,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 40,
    //             )
    //           ],
    //         ),
    //       );
    //     }
    //   },
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: ListView(
        children: const [
          OrdersItem(),
          OrdersItem(),
          OrdersItem(),
          OrdersItem(),
          OrdersItem(),
          OrdersItem(),
        ],
      ),
    );
  }
}

class OrdersItem extends StatelessWidget {
  const OrdersItem({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: const WidgetStatePropertyAll(kPrimary),
                  label: const Text(
                    'جاري التوصيل',
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                const Text(
                  '#44521',
                  style: TextStyle(
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
                ElevatedButton(
                  onPressed: () {},
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
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: null,
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
              ],
            )
          ],
        ),
      ),
    );
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
