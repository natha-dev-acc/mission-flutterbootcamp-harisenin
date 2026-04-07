import '../repositories/trip_repository.dart';

class DeleteTrip {
  final TripRepository repository;

  DeleteTrip(this.repository);

  Future<void> call(String id) {
    return repository.deleteTrip(id);
  }
}