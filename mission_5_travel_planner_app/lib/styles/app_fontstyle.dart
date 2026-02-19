import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'app_color.dart';

// Enum engine font
enum FontEngine { urbanist, inter }

// 💎 Integrasi `Sizer` langsung ke dalam `AppFonts` menjamin seluruh teks 
// di aplikasi kamu akan responsif secara otomatis. Sangat efisien! 📱📏
class AppFonts {
  static TextStyle base({
    required FontEngine engine,
    required double size,
    FontWeight weight = FontWeight.normal,
    FontStyle style = FontStyle.normal,
    Color? color,
  }) {
    if (engine == FontEngine.urbanist) {
      return GoogleFonts.urbanist(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
      );
    }

    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      fontStyle: style,
      color: color,
    );
  }
}

// Ukuran font standar
class AppFontSizes {
  static double get h1 => 24.sp;
  static double get bodyMd => 16.sp;
  static double get bodySm => 14.sp;
  static double get caption => 12.sp;
}

// Kumpulan style teks
class AppTextStyles {
  // Untuk tagline Splash Screen
  static TextStyle splashTagline(BuildContext context) {
    final c = AppColors.of(context);
    return AppFonts.base(
      engine: FontEngine.urbanist,
      size: AppFontSizes.h1,
      weight: FontWeight.w500,
      style: FontStyle.italic,
      color: c.textPrimary,
    );
  }

  // Untuk teks normal
  static TextStyle body(BuildContext context) {
    final c = AppColors.of(context);
    return AppFonts.base(
      engine: FontEngine.inter,
      size: AppFontSizes.bodyMd,
      color: c.textPrimary,
    );
  }

  // Untuk caption kecil
  static TextStyle caption(BuildContext context) {
    final c = AppColors.of(context);
    return AppFonts.base(
      engine: FontEngine.inter,
      size: AppFontSizes.caption,
      color: c.textSecondary,
    );
  }
}
