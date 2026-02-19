import 'package:flutter/material.dart';

// Kelas ini menyimpan seluruh definisi warna aplikasi
// 💎 Management warna yang terpusat seperti ini memudahkan maintenance 
// saat ingin melakukan rebranding atau tweaking UI secara global. Mantap! 🎨🌈
class AppColors {
  final Color background;
  final Color surface;
  final Color primary;
  final Color textPrimary;
  final Color textSecondary;

  const AppColors({
    required this.background,
    required this.surface,
    required this.primary,
    required this.textPrimary,
    required this.textSecondary,
  });

  // Mengambil warna berdasarkan mode (Light / Dark)
  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? dark
        : light;
  }

  // Light Mode (default)
  static const light = AppColors(
    background: Color(0xFFDBF7FF), // biru muda
    surface: Colors.white,
    primary: Color(0xFF2F4BB9),
    textPrimary: Colors.black,
    textSecondary: Color(0xFF828282),
  );

  // Dark Mode
  static const dark = AppColors(
    background: Color(0xFF102A43), // biru tua
    surface: Colors.black,
    primary: Color(0xFF2F4BB9),
    textPrimary: Colors.white,
    textSecondary: Colors.white,
  );
}
