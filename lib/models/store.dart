// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  String id;
  String storeName;
  String storeLogoUrl;
  String storePhone;
  String ownerFullName;
  String location;

  Store({
    required this.id,
    required this.storeName,
    required this.storeLogoUrl,
    required this.storePhone,
    required this.ownerFullName,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'storeName': storeName,
      'storeLogoUrl': storeLogoUrl,
      'storePhone': storePhone,
      'ownerFullName': ownerFullName,
      'location': location,
    };
  }

  factory Store.fromFirestore(DocumentSnapshot doc) {
    Map map = doc.data() as Map;
    return Store(
      id: map['id'] as String,
      storeName: map['storeName'] as String,
      storeLogoUrl: map['storeLogoUrl'] as String,
      storePhone: map['storePhone'] as String,
      ownerFullName: map['ownerFullName'] as String,
      location: map['location'] as String,
    );
  }
}
