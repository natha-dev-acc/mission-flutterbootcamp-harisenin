import '../entities/trip_entity.dart';
import '../repositories/trip_repository.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(TripEntity trip) {
    return repository.addTrip(trip);
  }
}