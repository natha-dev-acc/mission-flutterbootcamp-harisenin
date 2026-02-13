import 'package:hive/hive.dart';

import '../models/trip_model.dart';

// Service khusus database (Hive)
// UI TIDAK BOLEH langsung akses Hive
class TripService {
  // ================= SEARCH SOURCE (STATIC / TIDAK DISIMPAN) =================
  // Digunakan untuk halaman pilih trip
  static final List<Trip> allTrips = [
    Trip(
      title: 'Dramatic limestone island',
      subtitle: 'Halong Bay, Vietnam',
      image: 'assets/image/search/halong_bay.png',
    ),
    Trip(
      title: 'The Iconic White and Blue',
      subtitle: 'Santorini, Greece',
      image: 'assets/image/search/santorini.png',
    ),
    Trip(
      title: 'Iconic Urban Energy',
      subtitle: 'New York, USA',
      image: 'assets/image/search/new_york.png',
    ),
    Trip(
      title: 'Nature, Culture and Beach',
      subtitle: 'Bali, Indonesia',
      image: 'assets/image/search/bali.png',
    ),
    Trip(
      title: 'Golden Pavilion',
      subtitle: 'Kyoto, Japan',
      image: 'assets/image/search/kyoto.png',
    ),
  ];

  // ================= HIVE BOX =================
  static Box<Trip> get _box => Hive.box<Trip>('trips');

  // Load semua trip tersimpan
  static List<Trip> loadTrips() {
    return _box.values.toList();
  }

  // Tambah trip baru (auto-save)
  static void addTrip(Trip trip) {
    _box.add(trip);
  }

  // Update trip berdasarkan index
  static void updateTrip(int index, Trip updatedTrip) {
    _box.putAt(index, updatedTrip);
  }

  // Hapus trip
  static void deleteTrip(int index) {
    _box.deleteAt(index);
  }
}
