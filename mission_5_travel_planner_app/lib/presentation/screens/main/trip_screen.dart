import 'package:flutter/material.dart';
import '../../../core/styles/app_spacing.dart';
import '../../../core/styles/app_color.dart'; // Import warna aplikasi
import '../../widgets/wanderly_logo.dart';
import '../../widgets/trip_screen/title.dart';
import '../../widgets/trip_screen/filter.dart';
import '../../widgets/trip_screen/sort.dart';
import '../../widgets/trip_screen/list.dart';
import '../../widgets/trip_screen/add_button.dart'; // Import tombol baru

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi colors untuk mengambil warna background yang sesuai tema
    final colors = AppColors.of(context);

    return Scaffold(
      // Atur warna latar belakang agar mengikuti tema (Biru Muda/Biru Tua)
      backgroundColor: colors.background,
      
      // Pasang tombol add di sini
      floatingActionButton: const TripAddButton(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Center(child: WanderlyLogo()),
                  const SizedBox(height: 24),
                  const TripTitle(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(child: TripFilterDropdown()),
                      const SizedBox(width: 12),
                      const Expanded(child: TripSortDropdown()),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Expanded(child: TripList()),
          ],
        ),
      ),
    );
  }
}
