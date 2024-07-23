import 'package:flutter/material.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({super.key, required this.payload});
  final String payload;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Review Page'),
      ),
    );
  }
}
