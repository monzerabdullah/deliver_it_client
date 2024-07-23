import 'package:flutter/material.dart';

class TargetPage extends StatefulWidget {
  const TargetPage({super.key, required this.payload});
  final String payload;

  @override
  State<TargetPage> createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.payload);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Review Page'),
      ),
    );
  }
}
