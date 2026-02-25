import 'package:flutter/material.dart';

import '../../styles/app_spacing.dart';
import '../../styles/app_color.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/square_icon.dart';
import '../../widgets/save_button.dart';

class InputFormScreen extends StatefulWidget {
  final Set<IconData> initialActivities;
  final bool isEdit;

  const InputFormScreen({
    super.key,
    required this.initialActivities,
    required this.isEdit,
  });

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  late Set<IconData> selectedActivities;

  @override
  void initState() {
    super.initState();
    selectedActivities = {...widget.initialActivities};
  }

  // 💎 Penggunaan `setState` di sini sudah sangat tepat untuk mengelola state lokal form! 
  // Ini menunjukkan kamu sebenarnya sudah paham dasar manajemen state widget. Bagus! ✅✨
  // 💎 Logic toggle activity menggunakan `Set` adalah pilihan struktur data 
  // yang paling efisien karena otomatis mencegah duplikasi. Pro! 📈🛡️
  void toggleActivity(IconData icon) {
    setState(() {
      selectedActivities.contains(icon)
          ? selectedActivities.remove(icon)
          : selectedActivities.add(icon);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final outlineColor = isDark ? Colors.white : Colors.black;

    Widget selectable({
      required IconData icon,
      required String label,
    }) {
      final selected = selectedActivities.contains(icon);

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: selected
              ? Border.all(color: outlineColor, width: 2)
              : null,
        ),
        child: SquareIcon(
          icon: icon,
          label: label,
          onTap: () => toggleActivity(icon),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 32),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    selectable(icon: Icons.camera_alt, label: 'Sightseeing'),
                    selectable(icon: Icons.restaurant, label: 'Restaurant'),
                    selectable(icon: Icons.nightlife, label: 'Nightlife'),
                    selectable(icon: Icons.hotel, label: 'Hotel'),
                    selectable(icon: Icons.shopping_bag, label: 'Shopping'),
                    selectable(icon: Icons.movie, label: 'Cinema'),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SaveButton(
                label: widget.isEdit
                    ? 'Simpan Perubahan'
                    : 'Simpan Data Baru',
                onPressed: () {
                  Navigator.pop(context, selectedActivities);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
