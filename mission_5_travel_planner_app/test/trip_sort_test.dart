import 'package:flutter_test/flutter_test.dart';

import 'package:mission_5_travel_planner_app/data/models/trip_model.dart';

void main() {
  group('Trip Sort Test', () {
    final trips = [
      TripModel(
        id: '1',
        title: 'Old Trip',
        startDate: DateTime(2020),
        endDate: DateTime(2020),
        status: 'completed',
        createdAt: DateTime(2020),
        lat: 0,
        long: 0,
      ),
      TripModel(
        id: '2',
        title: 'New Trip',
        startDate: DateTime(2025),
        endDate: DateTime(2025),
        status: 'upcoming',
        createdAt: DateTime(2025),
        lat: 0,
        long: 0,
      ),
    ];

    test('Sort newest', () {
      trips.sort((a, b) => b.startDate.compareTo(a.startDate));

      expect(trips.first.title, 'New Trip');
    });

    test('Sort oldest', () {
      trips.sort((a, b) => a.startDate.compareTo(b.startDate));

      expect(trips.first.title, 'Old Trip');
    });
  });
}