import 'package:flutter/material.dart';

import '../../styles/app_spacing.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/square_icon.dart';

import '../../main.dart'; // ThemeController

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final isDark = themeController.isDark;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // const WanderlyLogo(),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 32),

            // GRID SETTINGS (ANTI OVERFLOW)
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                SquareIcon(
                  icon: isDark ? Icons.dark_mode : Icons.light_mode,
                  label: isDark ? 'Dark Mode' : 'Light Mode',
                  onTap: () {
                    themeController.toggleTheme(!isDark);
                  },
                ),
                const SquareIcon(
                  icon: Icons.card_travel,
                  label: 'Trip',
                ),
                const SquareIcon(
                  icon: Icons.notifications,
                  label: 'Notification Settings',
                ),
                const SquareIcon(
                  icon: Icons.person,
                  label: 'Profile Settings',
                ),
                const SquareIcon(
                  icon: Icons.info,
                  label: 'About Us',
                ),
                const SquareIcon(
                  icon: Icons.share,
                  label: 'Share the App',
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
