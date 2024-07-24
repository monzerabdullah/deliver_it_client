import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:deliver_it_client/services/notification_service.dart';
import 'package:deliver_it_client/views/authenticate.dart';
import 'package:deliver_it_client/views/home_view.dart';

import 'package:deliver_it_client/views/orders_view.dart';
import 'package:deliver_it_client/widgets/nav_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  setupLocator();
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  int currentIndex = 0;

  int readyTostartOrders = 0;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver It Client',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('store_id', isEqualTo: user?.uid)
                .where('status', isEqualTo: 'ready_to_start')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                readyTostartOrders = snapshot.data!.docs.length;
              }
              return Scaffold(
                appBar: AppBar(
                  elevation: 4.0,
                  backgroundColor: kWhite,
                  title: const Text(
                    'الرئيسية',
                  ),
                ),
                body: [const Home(), const MyOrders()][currentIndex],
                bottomNavigationBar: NavigationBar(
                  onDestinationSelected: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  selectedIndex: currentIndex,
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      selectedIcon: Icon(Icons.add_circle),
                      label: 'طلبية جديدة',
                    ),
                    NavigationDestination(
                      icon: Badge(
                        label: Text('$readyTostartOrders'),
                        isLabelVisible: readyTostartOrders > 0,
                        child: const Icon(Icons.list_alt),
                      ),
                      label: 'طلباتي',
                    ),
                  ],
                ),
                drawer: NavDrawer(),
              );
            }),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20.0,
            color: kPrimary,
          ),
          iconTheme: IconThemeData(
            color: kPrimary,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimary),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: kPrimaryText.withOpacity(.3),
          backgroundColor: kPrimary,
          iconTheme: const WidgetStatePropertyAll(
            IconThemeData(
              color: kWhite,
            ),
          ),
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: 'Cairo',
              color: kWhite,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthenticationService auth = locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: auth.user,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  Wrapper({super.key});
  final AuthenticationService _auth = locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      _auth.populateCurrentStore(user);
      return const ClientView();
    } else {
      return const Authenticate();
    }
  }
}
