import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../routes/app_routes.dart';

import '../../core/styles/app_color.dart';
import '../../core/styles/app_fontstyle.dart';

import '../widgets/wanderly_logo.dart';
import '../widgets/home_indicator.dart';

// Splash Screen (ONLY FIRST LAUNCH)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _firstLaunchKey = 'first_launch';

  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  Future<void> _handleStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(_firstLaunchKey) ?? true;

    final user = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(milliseconds: 800));

    if (isFirstLaunch) {
      // Tandai sudah pernah buka
      await prefs.setBool(_firstLaunchKey, false);

      // Tetap di splash → user klik tombol
      return;
    }

    // BUKAN FIRST LAUNCH → AUTO SKIP SPLASH
    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: const Center(
              child: WanderlyLogo(),
            ),
          ),

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
