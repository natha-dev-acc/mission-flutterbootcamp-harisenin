import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // upcoming, ongoing, completed
  final DateTime createdAt;

  // ================= NEW (GMap) =================
  final double lat;
  final double long;

  TripModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,

    // NEW
    required this.lat,
    required this.long,
  });

  // ================= FROM FIRESTORE =================
  factory TripModel.fromMap(String id, Map<String, dynamic> data) {
    return TripModel(
      id: id,
      title: data['title'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      status: data['status'] ?? 'upcoming',
      createdAt: (data['createdAt'] as Timestamp).toDate(),

      // ================= NEW =================
      lat: (data['lat'] ?? 0).toDouble(),
      long: (data['long'] ?? 0).toDouble(),
    );
  }

  // ================= TO FIRESTORE =================
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),

      // ================= NEW =================
      'lat': lat,
      'long': long,
    };
  }

  // ================= COPY =================
  TripModel copyWith({
    String? id,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    DateTime? createdAt,

    // NEW
    double? lat,
    double? long,
  }) {
    return TripModel(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,

      // NEW
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// class TripModel {
//   final String id;
//   final String title;
//   final DateTime startDate;
//   final DateTime endDate;
//   final String status; // upcoming, ongoing, completed
//   final DateTime createdAt;

//   TripModel({
//     required this.id,
//     required this.title,
//     required this.startDate,
//     required this.endDate,
//     required this.status,
//     required this.createdAt,
//   });

//   // ================= FROM FIRESTORE =================
//   factory TripModel.fromMap(String id, Map<String, dynamic> data) {
//     return TripModel(
//       id: id,
//       title: data['title'] ?? '',
//       startDate: (data['startDate'] as Timestamp).toDate(),
//       endDate: (data['endDate'] as Timestamp).toDate(),
//       status: data['status'] ?? 'upcoming',
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//     );
//   }

//   // ================= TO FIRESTORE =================
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'startDate': Timestamp.fromDate(startDate),
//       'endDate': Timestamp.fromDate(endDate),
//       'status': status,
//       'createdAt': Timestamp.fromDate(createdAt),
//     };
//   }

//   // ================= COPY =================
//   TripModel copyWith({
//     String? id,
//     String? title,
//     DateTime? startDate,
//     DateTime? endDate,
//     String? status,
//     DateTime? createdAt,
//   }) {
//     return TripModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       startDate: startDate ?? this.startDate,
//       endDate: endDate ?? this.endDate,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }