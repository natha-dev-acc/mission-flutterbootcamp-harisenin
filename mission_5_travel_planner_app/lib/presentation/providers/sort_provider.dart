import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum sort
enum TripSort {
  newest, // startDate terbaru
  oldest, // startDate terlama
}

// State sort
class SortNotifier extends Notifier<TripSort> {
  @override
  TripSort build() {
    return TripSort.newest;
  }

  void setSort(TripSort sort) {
    state = sort;
  }
}

// Provider
final sortProvider =
    NotifierProvider<SortNotifier, TripSort>(SortNotifier.new);