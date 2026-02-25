import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../styles/app_color.dart';
import '../styles/app_fontstyle.dart';
import '../widgets/wanderly_logo.dart';
import '../widgets/home_indicator.dart';

// Halaman Splash Screen
// 💎 Splash Screen dengan `Stack` dan `Positioned` menunjukkan kamu paham 
// konsep layering UI yang kompleks. Hasilnya sangat presisi! 🎨✨
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // LOGO – POSISI ABSOLUT (ANTI KETIMPA)
          Positioned(
            top: 80, // geser dari atas (aman dari box)
            left: 0,
            right: 0,
            child: const Center(
              child: WanderlyLogo(),
            ),
          ),

          // BOX PUTIH / HITAM BAWAH
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 355,
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(69),
                  topRight: Radius.circular(69),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      'Explore the world effortlessly',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.splashTagline(context),
                    ),
                  ),

                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: () {
                      // Navigasi ke Login Screen menggunakan Named Routes
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login,
                      );
                    },
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 71,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // HOME INDICATOR – FIX DI BAWAH LAYAR
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeIndicator(),
          ),
        ],
      ),
    );
  }
}
