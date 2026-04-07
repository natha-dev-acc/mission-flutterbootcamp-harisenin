import 'package:flutter/material.dart';
import '../../core/styles/app_color.dart';

// Widget Bottom Navigation Bar utama aplikasi
// Digunakan untuk navigasi Home, Search, Trip, dan Profile
class WanderlyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const WanderlyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 83,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
      ),
      child: Column(
        children: [
          // ===== Row Icon =====
          SizedBox(
            height: 49,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavIcon(
                  icon: Icons.map_outlined,
                  index: 0,
                  currentIndex: currentIndex,
                  onTap: onTap,
                  color: colors.primary,
                ),
                // _NavIcon(
                //   icon: Icons.search,
                //   index: 1,
                //   currentIndex: currentIndex,
                //   onTap: onTap,
                //   color: colors.primary,
                // ),
                _NavIcon(
                  icon: Icons.checklist_outlined,
                  index: 1,
                  currentIndex: currentIndex,
                  onTap: onTap,
                  color: colors.primary,
                ),
                _NavIcon(
                  icon: Icons.settings_outlined,
                  index: 2,
                  currentIndex: currentIndex,
                  onTap: onTap,
                  color: colors.primary,
                ),
              ],
            ),
          ),

          // ===== Indicator =====
          SizedBox(
            height: 34,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Icon Item =====
class _NavIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color color;

  const _NavIcon({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: 26,
        // PERBAIKAN DI SINI: Menggunakan .withValues menggantikan .withOpacity
        color: isActive ? color : color.withValues(alpha: 0.5),
      ),
    );
  }
}
