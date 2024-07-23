import 'package:deliver_it_client/views/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          _onDidReceiveNotificationResponse, // Updated callback
    );
  }

  Future<void> _onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    // Handle notification tap
    if (response.payload != null) {
      // Navigate to TargetPage or any other page
      // print(response.payload);
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => StoreReviewTripScreen(
            payload: response.payload!,
          ),
        ),
      );
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'sample_payload', // You can pass any payload here
    );
  }

  void listenToFirestoreDocument(String collection) {
    FirebaseFirestore.instance
        .collection(collection)
        .snapshots()
        .listen((snapshot) {
      print('Firestore snapshot received');
      for (var docChange in snapshot.docChanges) {
        print('Document change type: ${docChange.type}');
        if (docChange.type != DocumentChangeType.modified) {
          var newData = docChange.doc.data();
          print('Modified document data: $newData');
          if (newData != null && newData['status'] == 'delivered') {
            showNotification('Notification Title', 'Notification Body');
          }
        }
      }
    });
  }
}
