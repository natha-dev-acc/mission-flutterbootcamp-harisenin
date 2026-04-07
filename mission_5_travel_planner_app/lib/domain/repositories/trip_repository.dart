import '../entities/trip_entity.dart';

abstract class TripRepository {
  Stream<List<TripEntity>> getTrips();

  Future<void> addTrip(TripEntity trip);

  Future<void> updateTrip(TripEntity trip);

  Future<void> deleteTrip(String id);
}