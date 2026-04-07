import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../styles/app_spacing.dart';

import '../../providers/trip_provider.dart';
import '../../providers/filter_provider.dart';
import '../../providers/sort_provider.dart';

import '../../screens/trip/edit_trip_screen.dart';

class TripList extends ConsumerWidget {
  const TripList({super.key});

  // ================= CONFIRM DELETE =================
  void _confirmDelete(BuildContext context, WidgetRef ref, trip) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text(
          'Yakin mau hapus Trip dengan judul:\n"${trip.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            // onPressed: () async {
            //   Navigator.pop(context);

            //   await ref.read(tripProvider.notifier).deleteTrip(trip.id);

            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('Trip berhasil dihapus'),
            //     ),
            //   );
            // },
            onPressed: () async {
              Navigator.pop(context);

              // 1. Tunggu proses hapus selesai
              await ref.read(tripProvider.notifier).deleteTrip(trip.id);

              // 2. CEK APAKAH CONTEXT MASIH VALID (Solusinya di sini)
              if (!context.mounted) return; 

              // 3. Sekarang aman menggunakan context
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Trip berhasil dihapus'),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripState = ref.watch(tripProvider);
    final trips = ref.watch(filteredSortedTripsProvider);

    final currentFilter = ref.watch(filterProvider);
    final currentSort = ref.watch(sortProvider);

    if (tripState.isLoading && trips.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tripState.error != null) {
      return Center(
        child: Text(
          tripState.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (trips.isEmpty) {
      return Center(
        child: Text('Belum ada trip (${currentFilter.name})'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 8,
          ),
          child: Text(
            "Showing ${currentFilter.name} • ${currentSort.name}",
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    trip.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${trip.status} • ${trip.startDate.day}/${trip.startDate.month}/${trip.startDate.year}",
                  ),

                  // ===== ACTION BUTTONS =====
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ===== EDIT =====
                      IconButton(
                        icon: const Icon(
                          Icons.mode_edit_outline,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditTripScreen(trip: trip),
                            ),
                          );
                        },
                      ),

                      // ===== DELETE =====
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            _confirmDelete(context, ref, trip),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
