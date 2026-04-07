import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum biar aman & clean (tidak pakai string bebas)
enum TripFilter {
  all,
  upcoming,
  ongoing,
  completed,
}

// State filter
class FilterNotifier extends Notifier<TripFilter> {
  @override
  TripFilter build() {
    return TripFilter.all;
  }

  void setFilter(TripFilter filter) {
    state = filter;
  }
}

// Provider
final filterProvider =
    NotifierProvider<FilterNotifier, TripFilter>(FilterNotifier.new);