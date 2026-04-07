import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mission_5_travel_planner_app/data/models/trip_model.dart';

void main() {
  group('TripModel Test', () {
    test('fromMap harus parse data dengan benar', () {
      final data = {
        'title': 'Bali Trip',
        'startDate': Timestamp.fromDate(DateTime(2025, 1, 1)),
        'endDate': Timestamp.fromDate(DateTime(2025, 1, 2)),
        'status': 'upcoming',
        'createdAt': Timestamp.fromDate(DateTime(2024, 12, 1)),
        'lat': -8.409518,
        'long': 115.188919,
      };

      final trip = TripModel.fromMap('1', data);

      expect(trip.id, '1');
      expect(trip.title, 'Bali Trip');
      expect(trip.status, 'upcoming');
      expect(trip.lat, -8.409518);
      expect(trip.long, 115.188919);
    });

    test('toMap harus convert ke Map dengan benar', () {
      final trip = TripModel(
        id: '1',
        title: 'Test Trip',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2025, 1, 2),
        status: 'ongoing',
        createdAt: DateTime(2024, 12, 1),
        lat: -8.0,
        long: 115.0,
      );

      final map = trip.toMap();

      expect(map['title'], 'Test Trip');
      expect(map['status'], 'ongoing');
      expect(map['lat'], -8.0);
      expect(map['long'], 115.0);
    });
  });
}