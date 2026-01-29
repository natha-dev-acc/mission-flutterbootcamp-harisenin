import 'package:flutter/material.dart';
import '../styles/app_color.dart';

class WanderlySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final ValueChanged<String>? onChanged;

  const WanderlySearchBar({
    super.key,
    required this.controller,
    this.placeholder = 'Search your destination',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.menu, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
                isCollapsed: true,
              ),
              style: TextStyle(color: colors.textPrimary),
            ),
          ),
          Icon(
            Icons.search,
            color: isDark ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
