import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/trip_remote_datasource.dart';
import '../../data/models/trip_model.dart';

import 'filter_provider.dart';
import 'sort_provider.dart';

// ================= STATE =================
class TripState {
  final List<TripModel> trips;
  final bool isLoading;
  final String? error;

  TripState({
    this.trips = const [],
    this.isLoading = false,
    this.error,
  });

  TripState copyWith({
    List<TripModel>? trips,
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
  final TripRemoteDatasource _datasource = TripRemoteDatasource();
  StreamSubscription<List<TripModel>>? _subscription;

  @override
  TripState build() {
    // FIX: Gunakan Future.microtask agar dijalankan tepat SETELAH build selesai.
    Future.microtask(() => _listenTrips());

    ref.onDispose(() {
      _subscription?.cancel();
    });

    // Inisialisasi awal dengan status loading
    return TripState(isLoading: true);
  }

  // ================= LISTEN REALTIME =================
  void _listenTrips() {
    // Tidak perlu memanggil state.copyWith(isLoading: true) di sini 
    // karena sudah diatur saat return awal di fungsi build()
    _subscription = _datasource.getTrips().listen(
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

  // ================= ADD =================
  Future<void> addTrip(TripModel trip) async {
    try {
      state = state.copyWith(isLoading: true);
      await _datasource.addTrip(trip);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // ================= UPDATE =================
  Future<void> updateTrip(TripModel trip) async {
    try {
      await _datasource.updateTrip(trip);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // ================= DELETE =================
  Future<void> deleteTrip(String id) async {
    try {
      await _datasource.deleteTrip(id);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// ================= BASE PROVIDER =================
final tripProvider =
    NotifierProvider<TripNotifier, TripState>(TripNotifier.new);

// =======================================================
// DERIVED PROVIDER (FILTER + SORT)
// =======================================================
final filteredSortedTripsProvider = Provider<List<TripModel>>((ref) {
  final trips = ref.watch(tripProvider).trips;
  final filter = ref.watch(filterProvider);
  final sort = ref.watch(sortProvider);

  // ================= FILTER =================
  List<TripModel> result = trips.where((trip) {
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

  // ================= SORT =================
  result.sort((a, b) {
    if (sort == TripSort.newest) {
      return b.startDate.compareTo(a.startDate);
    } else {
      return a.startDate.compareTo(b.startDate);
    }
  });

  return result;
});
