import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/models/store.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';
import '../models/rider_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _stores =
      FirebaseFirestore.instance.collection('stores');

  Future createStore(Store store) async {
    try {
      await _stores.doc(store.id).set(store.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getStore(String storeId) async {
    try {
      var storeData = await _stores.doc(storeId).get();
      return Store.fromFirestore(storeData);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createOrder(User? user) async {
    if (user == null) {
      print('User is null');
      return;
    }

    var storeDoc = await _stores.doc(user.uid).get();

    if (!storeDoc.exists) {
      print('Store document does not exist');
      return;
    }

    var storeData = storeDoc.data() as Map;
    await _firestore.collection('orders').add({
      'store_id': user.uid,
      'store_name': storeData['storeName'],
      'storeLogoUrl': storeData['storeLogoUrl'],
      'location': storeData['location'],
      'storePhone': storeData['storePhone'],
      'rider_id': null,
      'status': 'pending',
      'order_details': '',
      'visibility': 'public',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  // Future<void> createOrder(User? user) async {
  //   if (user != null) {
  //     await _firestore.collection('orders').add({
  //       'store_id': user.uid,
  //       'rider_id': null,
  //       'status': 'pending',
  //       'order_details': '',
  //       'visibility': 'public',
  //       'created_at': FieldValue.serverTimestamp(),
  //     });
  //   }
  // }

  // return ready_to_start orders
  Stream<QuerySnapshot<Map<String, dynamic>>> readyToStartOrders(
      String storeId) {
    return _firestore
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .where('status', isEqualTo: 'ready_to_start')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allOrders(String storeId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .snapshots();
  }

  Stream<QuerySnapshot> activeOrders(String storeId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .where(
      'status',
      whereIn: [
        'pending',
        'accepted',
        'ready_to_start',
        'delivering',
      ],
    ).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> acceptedOrders(String storeId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .where('status', isEqualTo: 'accepted')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> canceldOrders(String storeId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .where('status', isEqualTo: 'canceled')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> deliveredOrders(String storeId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .where('status', isEqualTo: 'delivered')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> deliveringOrders(String storeId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .where('status', isEqualTo: 'delivering')
        .snapshots();
  }

  Future<void> confirmTrip(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'delivering',
    });
  }

  Future<void> cancelOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': 'canceled',
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderWithId(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots();
  }

  Stream<List<OrderModel>> getOrders(String storeId) {
    return _firestore
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  Stream<List<Rider>> getRiders() {
    return _firestore.collection('riders').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Rider.fromFirestore(doc)).toList());
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }

  Future<void> updateRiderStatus(String riderId, String status) async {
    await _firestore
        .collection('riders')
        .doc(riderId)
        .update({'status': status});
  }

  Future<void> updateRiderShift(
      String riderId, DateTime shiftStart, DateTime? shiftEnd) async {
    await _firestore.collection('riders').doc(riderId).update({
      'shift_start': Timestamp.fromDate(shiftStart),
      'shift_end': shiftEnd != null ? Timestamp.fromDate(shiftEnd) : null,
    });
  }
}
