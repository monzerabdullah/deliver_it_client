import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';
import '../models/rider_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationService _auth = locator<AuthenticationService>();
  Stream<List<OrderModel>> getOrders(String storeId) {
    return _db
        .collection('orders')
        .where('store_id', isEqualTo: storeId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  Stream<List<Rider>> getRiders() {
    return _db.collection('riders').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Rider.fromFirestore(doc)).toList());
  }

  Future<void> createOrder(User? user) async {
    if (user != null) {
      await _db.collection('orders').add({
        'store_id': user.uid,
        'rider_id': null,
        'status': 'pending',
        'order_details': '',
        'visibility': 'public',
        'created_at': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({'status': status});
  }

  Future<void> updateRiderStatus(String riderId, String status) async {
    await _db.collection('riders').doc(riderId).update({'status': status});
  }

  Future<void> updateRiderShift(
      String riderId, DateTime shiftStart, DateTime? shiftEnd) async {
    await _db.collection('riders').doc(riderId).update({
      'shift_start': Timestamp.fromDate(shiftStart),
      'shift_end': shiftEnd != null ? Timestamp.fromDate(shiftEnd) : null,
    });
  }
}
