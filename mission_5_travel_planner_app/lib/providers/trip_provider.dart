import 'package:flutter_riverpod/legacy.dart';

import '../models/trip_model.dart';
import '../services/trip_service.dart';

// State Trip
// Menyimpan daftar trip dan status loading
class TripState {
  final List<Trip> trips;
  final bool isLoading;

  TripState({
    required this.trips,
    required this.isLoading,
  });

  // Helper untuk update sebagian state
  TripState copyWith({
    List<Trip>? trips,
    bool? isLoading,
  }) {
    return TripState(
      trips: trips ?? this.trips,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// StateNotifier untuk mengelola seluruh logika bisnis Trip
// UI TIDAK BOLEH melakukan manipulasi data langsung
class TripNotifier extends StateNotifier<TripState> {
  TripNotifier() : super(TripState(trips: [], isLoading: true)) {
    // Load data dari Hive saat provider pertama kali dibuat
    loadTrips();
  }

  // Load awal data dari Hive
  // Aman jika database kosong
  void loadTrips() {
    state = state.copyWith(isLoading: true);

    final data = TripService.loadTrips();

    state = state.copyWith(
      trips: data,
      isLoading: false,
    );
  }

  // Tambah trip baru
  // Data otomatis tersimpan ke Hive
  void addTrip(Trip trip) {
    TripService.addTrip(trip);
    loadTrips();
  }

  // Update trip berdasarkan index
  void updateTrip(int index, Trip updatedTrip) {
    TripService.updateTrip(index, updatedTrip);
    loadTrips();
  }

  // Hapus trip
  void deleteTrip(int index) {
    TripService.deleteTrip(index);
    loadTrips();
  }
}

// Provider global Trip
// UI hanya boleh watch & read provider ini
final tripProvider =
    StateNotifierProvider<TripNotifier, TripState>((ref) {
  return TripNotifier();
});
