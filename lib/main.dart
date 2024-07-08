import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/home_view.dart';
import 'package:deliver_it_client/views/login_view.dart';
import 'package:deliver_it_client/views/orders_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver It Client',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: [const Home(), const MyOrders()][currentIndex],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            selectedIndex: currentIndex,
            indicatorColor: kPrimary,
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.add_circle_outline,
                ),
                selectedIcon: Icon(Icons.add_circle),
                label: 'طلبية جديدة',
              ),
              NavigationDestination(
                icon: Icon(Icons.list_alt),
                label: 'طلباتي',
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimary),
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }
}
