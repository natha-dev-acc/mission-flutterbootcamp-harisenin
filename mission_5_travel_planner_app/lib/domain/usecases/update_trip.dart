import '../entities/trip_entity.dart';
import '../repositories/trip_repository.dart';

class UpdateTrip {
  final TripRepository repository;

  UpdateTrip(this.repository);

  Future<void> call(TripEntity trip) {
    return repository.updateTrip(trip);
  }
}