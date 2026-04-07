import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/trip_remote_datasource.dart';
import '../../data/repositories/trip_repository_impl.dart';

import '../../domain/entities/trip_entity.dart';
import '../../domain/usecases/add_trip.dart';
import '../../domain/usecases/delete_trip.dart';
import '../../domain/usecases/get_trips.dart';
import '../../domain/usecases/update_trip.dart';

import 'filter_provider.dart';
import 'sort_provider.dart';

// ================= STATE =================
class TripState {
  final List<TripEntity> trips;
  final bool isLoading;
  final String? error;

  TripState({
    this.trips = const [],
    this.isLoading = false,
    this.error,
  });

  TripState copyWith({
    List<TripEntity>? trips,
    bool? isLoading,
    String? error,
  }) {
    return TripState(
      trips: trips ?? this.trips,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ================= NOTIFIER =================
class TripNotifier extends Notifier<TripState> {
  late final AddTrip _addTrip;
  late final GetTrips _getTrips;
  late final UpdateTrip _updateTrip;
  late final DeleteTrip _deleteTrip;

  StreamSubscription<List<TripEntity>>? _subscription;

  @override
  TripState build() {
    final datasource = TripRemoteDatasource();
    final repository = TripRepositoryImpl(datasource);

    _addTrip = AddTrip(repository);
    _getTrips = GetTrips(repository);
    _updateTrip = UpdateTrip(repository);
    _deleteTrip = DeleteTrip(repository);

    Future.microtask(() => _listenTrips());

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return TripState(isLoading: true);
  }

  void _listenTrips() {
    _subscription = _getTrips().listen(
      (trips) {
        state = state.copyWith(
          trips: trips,
          isLoading: false,
          error: null,
        );
      },
      onError: (e) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
      },
    );
  }

  Future<void> addTrip(TripEntity trip) async {
    await _addTrip(trip);
  }

  Future<void> updateTrip(TripEntity trip) async {
    await _updateTrip(trip);
  }

  Future<void> deleteTrip(String id) async {
    await _deleteTrip(id);
  }
}

// ================= PROVIDER =================
final tripProvider =
    NotifierProvider<TripNotifier, TripState>(TripNotifier.new);

// ================= FILTER + SORT =================
final filteredSortedTripsProvider = Provider<List<TripEntity>>((ref) {
  final trips = ref.watch(tripProvider).trips;
  final filter = ref.watch(filterProvider);
  final sort = ref.watch(sortProvider);

  List<TripEntity> result = trips.where((trip) {
    switch (filter) {
      case TripFilter.upcoming:
        return trip.status == 'upcoming';
      case TripFilter.ongoing:
        return trip.status == 'ongoing';
      case TripFilter.completed:
        return trip.status == 'completed';
      case TripFilter.all:
        return true;
    }
  }).toList();

  result.sort((a, b) {
    if (sort == TripSort.newest) {
      return b.startDate.compareTo(a.startDate);
    } else {
      return a.startDate.compareTo(b.startDate);
    }
  });

  return result;
});