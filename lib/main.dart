import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver It Client',
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimary),
      ),
    );
  }
}
