import '../entities/trip_entity.dart';
import '../repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  Stream<List<TripEntity>> call() {
    return repository.getTrips();
  }
}