import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/trip_entity.dart';

class TripModel extends TripEntity {
  TripModel({
    required super.id,
    required super.title,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.createdAt,
    required super.lat,
    required super.long,
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
      'lat': lat,
      'long': long,
    };
  }

  // ================= FROM ENTITY =================
  factory TripModel.fromEntity(TripEntity entity) {
    return TripModel(
      id: entity.id,
      title: entity.title,
      startDate: entity.startDate,
      endDate: entity.endDate,
      status: entity.status,
      createdAt: entity.createdAt,
      lat: entity.lat,
      long: entity.long,
    );
  }

  // ================= COPY =================
  // Menambahkan kembali copyWith yang hilang untuk digunakan di Datasource
  TripModel copyWith({
    String? id,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    DateTime? createdAt,
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
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }
}
