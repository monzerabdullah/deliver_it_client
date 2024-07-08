import 'package:flutter/material.dart';
import 'package:deliver_it_client/constants.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  int orderStatus = 0;

  void _toggleStatus() {
    setState(() {
      if (orderStatus == 0) {
        orderStatus = 1;
      } else if (orderStatus == 1) {
        orderStatus = 2;
      } else if (orderStatus == 2) {
        orderStatus = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleStatus,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 5),
                decoration: BoxDecoration(
                  color: orderStatus == 0
                      ? const Color(0xFF7F7F7F)
                      : orderStatus == 1
                          ? kPrimary
                          : kSecondary,
                  borderRadius: BorderRadius.circular(224 / 2),
                  boxShadow: kElevationToShadow[3],
                ),
                width: 224,
                height: 224,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kPrimaryText,
                  borderRadius: BorderRadius.circular(195 / 2),
                ),
                width: 195,
                height: 195,
                child: Text(
                  orderStatus == 0
                      ? 'أطلب مندوب'
                      : orderStatus == 1
                          ? 'إنتظار المندوب...'
                          : 'تم قبول الرحلة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22.0,
                    color: orderStatus == 0
                        ? const Color(0xFF7F7F7F)
                        : orderStatus == 1
                            ? kPrimary
                            : kSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          RichText(
            textDirection: TextDirection.rtl,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'إضغط',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: kSecondaryText,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(
                  text: ' مطولا ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: kPrimary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'على الزر لطلب مندوب أخر',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: kSecondaryText,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
