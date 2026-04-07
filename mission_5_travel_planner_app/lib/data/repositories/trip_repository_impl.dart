import '../../domain/entities/trip_entity.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasource/trip_remote_datasource.dart';
import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDatasource remoteDatasource;

  TripRepositoryImpl(this.remoteDatasource);

  @override
  Stream<List<TripEntity>> getTrips() {
    return remoteDatasource.getTrips().map(
          (models) => models,
        );
  }

  @override
  Future<void> addTrip(TripEntity trip) async {
    final model = TripModel.fromEntity(trip);
    await remoteDatasource.addTrip(model);
  }

  @override
  Future<void> updateTrip(TripEntity trip) async {
    final model = TripModel.fromEntity(trip);
    await remoteDatasource.updateTrip(model);
  }

  @override
  Future<void> deleteTrip(String id) async {
    await remoteDatasource.deleteTrip(id);
  }
}