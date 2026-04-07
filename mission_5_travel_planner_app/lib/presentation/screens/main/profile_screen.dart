import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../styles/app_spacing.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/square_icon.dart';

import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';

import '../../../routes/app_routes.dart';

// Profile Screen (Settings)
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  // ===== DIALOG LOGOUT =====
  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Anda yakin mau keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('No...'),
          ),
          TextButton(
            onPressed: () async {
              // Ambil navigator sebelum await (untuk menghindari async gaps)
              final navigator = Navigator.of(context);
              
              // Tutup dialog
              Navigator.pop(dialogContext);

              // LOGOUT via provider
              await ref.read(authProvider.notifier).logout();

              // Gunakan referensi navigator yang sudah disimpan untuk pindah ke Login
              navigator.pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
            child: const Text('Yes!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: 16),

            const Center(child: WanderlyLogo()),

            const SizedBox(height: 32),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                // ===== DARK MODE =====
                SquareIcon(
                  icon: isDark ? Icons.dark_mode : Icons.light_mode,
                  label: isDark ? 'Dark Mode' : 'Light Mode',
                  onTap: () {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),

                // ===== LOGOUT =====
                SquareIcon(
                  icon: Icons.logout,
                  label: 'Log Out',
                  onTap: () => _confirmLogout(context, ref),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
