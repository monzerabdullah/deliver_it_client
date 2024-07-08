import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/widgets/order_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: kPrimaryText,
            ),
          ),
          backgroundColor: Colors.grey[100],
          title: const Text(
            'الرئيسية',
            style: TextStyle(
              fontFamily: 'Cairo',
              color: kPrimaryText,
            ),
          ),
        ),
        body: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              OrderButton(),
            ],
          ),
        ),
      ),
    );
  }
}
