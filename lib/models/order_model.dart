import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  String riderId;
  String storeId;
  String neighborhoodId;
  double distanceKm;
  double price;
  String receiptImageUrl;
  String clientNumber;
  String status; // 'pending_review', 'approved', 'rejected'

  OrderModel({
    required this.id,
    required this.riderId,
    required this.storeId,
    required this.neighborhoodId,
    required this.distanceKm,
    required this.price,
    required this.receiptImageUrl,
    required this.clientNumber,
    required this.status,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return OrderModel(
      id: doc.id,
      riderId: data['rider_id'] ?? '',
      storeId: data['store_id'] ?? '',
      neighborhoodId: data['neighborhood_id'] ?? '',
      distanceKm: data['distance_km'] ?? 0.0,
      price: data['price'] ?? 0.0,
      receiptImageUrl: data['receipt_image_url'] ?? '',
      clientNumber: data['client_number'] ?? '',
      status: data['status'] ?? 'pending_review',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rider_id': riderId,
      'store_id': storeId,
      'neighborhood_id': neighborhoodId,
      'distance_km': distanceKm,
      'price': price,
      'receipt_image_url': receiptImageUrl,
      'client_number': clientNumber,
      'status': status,
    };
  }
}
