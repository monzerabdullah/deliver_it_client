import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  String id;
  String name;
  String status; // 'online', 'offline'
  DateTime? shiftStart;
  DateTime? shiftEnd;

  Rider({
    required this.id,
    required this.name,
    required this.status,
    this.shiftStart,
    this.shiftEnd,
  });

  factory Rider.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Rider(
      id: doc.id,
      name: data['name'] ?? '',
      status: data['status'] ?? 'offline',
      shiftStart: (data['shift_start'] as Timestamp?)?.toDate(),
      shiftEnd: (data['shift_end'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'shift_start':
          shiftStart != null ? Timestamp.fromDate(shiftStart!) : null,
      'shift_end': shiftEnd != null ? Timestamp.fromDate(shiftEnd!) : null,
    };
  }
}
