import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:deliver_it_client/widgets/order_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              await AuthenticationService().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ),
        backgroundColor: Colors.grey[100],
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
