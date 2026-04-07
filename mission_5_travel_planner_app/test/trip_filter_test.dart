import 'package:flutter_test/flutter_test.dart';

import 'package:mission_5_travel_planner_app/data/models/trip_model.dart';

void main() {
  group('Trip Filter Test', () {
    final trips = [
      TripModel(
        id: '1',
        title: 'Trip 1',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: 'upcoming',
        createdAt: DateTime.now(),
        lat: 0,
        long: 0,
      ),
      TripModel(
        id: '2',
        title: 'Trip 2',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: 'completed',
        createdAt: DateTime.now(),
        lat: 0,
        long: 0,
      ),
    ];

    test('Filter upcoming', () {
      final result =
          trips.where((trip) => trip.status == 'upcoming').toList();

      expect(result.length, 1);
      expect(result.first.title, 'Trip 1');
    });

    test('Filter completed', () {
      final result =
          trips.where((trip) => trip.status == 'completed').toList();

      expect(result.length, 1);
      expect(result.first.title, 'Trip 2');
    });
  });
}