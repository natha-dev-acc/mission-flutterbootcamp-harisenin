import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/trip_model.dart';
import '../../providers/trip_provider.dart';
import '../../services/trip_service.dart';

import '../../styles/app_spacing.dart';
import '../../styles/app_color.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/trip_item.dart';
import '../../widgets/save_button.dart';

import 'input_form_screen.dart';

// Halaman untuk memilih destinasi trip awal
// Data trip statis diambil dari TripService.allTrips
// Penyimpanan data dilakukan melalui Riverpod Provider
// 💎 `ChooseTripScreen` yang simpel namun efektif dalam memisahkan pemilihan destinasi 
// dan pengisian form aktivitas. Penggunaan `SaveButton` di sini sangat konsisten! 🚢🗺️
class ChooseTripScreen extends ConsumerWidget {
  const ChooseTripScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 32),

            // ===== LIST TRIP (PILIH LOKASI) =====
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                itemCount: TripService.allTrips.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final Trip baseTrip =
                      TripService.allTrips[index];

                  return TripItem(
                    title: baseTrip.title,
                    subtitle: baseTrip.subtitle,
                    imagePath: baseTrip.image,
                    onTap: () async {
                      // Pilih aktivitas
                      final activities =
                          await Navigator.push<Set<IconData>>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InputFormScreen(
                            initialActivities: {},
                            isEdit: false,
                          ),
                        ),
                      );

                      if (activities != null &&
                          activities.isNotEmpty) {
                        // Buat Trip baru dengan aktivitas terpilih
                        final newTrip =
                            baseTrip.copyWithActivities(
                          activities,
                        );

                        // Simpan data melalui Provider (auto-save Hive)
                        ref
                            .read(tripProvider.notifier)
                            .addTrip(newTrip);

                        // Kembali ke TripScreen
                        Navigator.pop(context);

                        // Notifikasi sukses
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text('Rencana perjalanan ditambahkan'),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),

            // ===== BUTTON KEMBALI =====
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: SaveButton(
                label: '← Kembali',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
