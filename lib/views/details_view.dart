import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/firestore_service.dart';

import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  DetailsView({super.key, required this.orderId});
  final String orderId;
  final FirestoreService _firestore = locator<FirestoreService>();

  String chaipLabel(String orderStatus) {
    if (orderStatus == 'pending') {
      return 'في إنتظار القبول';
    } else if (orderStatus == 'accepted') {
      return 'تم القبول';
    } else if (orderStatus == 'ready_to_start') {
      return 'جاهز للتوصيل';
    } else if (orderStatus == 'delivering') {
      return 'جاري للتوصيل';
    } else if (orderStatus == 'rejected') {
      return 'ملغية';
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
    } else if (orderStatus == 'rejected') {
      return const WidgetStatePropertyAll(kRed);
    } else {
      return const WidgetStatePropertyAll(kPrimary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _firestore.orderWithId(orderId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('No Details Yet');
              }
              final order = snapshot.data!;

              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        order.data()!.containsKey('recipient_image_url')
                            ? Image.network(
                                '${order.get('recipient_image_url')}',
                                width: 300,
                              )
                            : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                          width: 0,
                                        ),
                                      ),
                                      color: chipColor(
                                        order.get('status'),
                                      ),
                                      label: Text(
                                        chaipLabel(
                                          order.get('status'),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'الحالة',
                                    ),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('LE 25'),
                                    Text(
                                      '22 يونيو ، 2024 ،  PM 8:04',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('مكان الإستلام'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: kPrimary,
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('السادس من اكتبوبر ، الحي الثاني'),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: kPrimary,
                              child: Icon(
                                Icons.phone,
                                color: kWhite,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('مكان التوصيل'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: kPrimary,
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('السادس من اكتبوبر ، الحي الثاني'),
                              ],
                            ),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: kPrimary,
                                  child: Icon(
                                    Icons.phone,
                                    color: kWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _firestore.confirmTrip(order.id);
                            Navigator.pop(context);
                          },
                          child: const Text('تأكيد'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
