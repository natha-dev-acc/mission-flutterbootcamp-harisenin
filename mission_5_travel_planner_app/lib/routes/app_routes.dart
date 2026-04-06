import 'package:flutter/material.dart';

// Splash & Auth
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';

// Main Shell (OTAK NAVIGASI)
import '../screens/main/main_shell_screen.dart';

// Kumpulan Named Routes aplikasi
class AppRoutes {
  // Route name constants
  static const splash   = '/splash';
  static const login    = '/login';
  static const register = '/register';
  static const home     = '/home';

  // Mapping route ke halaman
  static Map<String, WidgetBuilder> routes = {
    // Splash Screen
    splash: (context) => const SplashScreen(),

    // Auth Screens
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),

    // MAIN ENTRY SETELAH LOGIN
    home: (context) => const MainShellScreen(),
  };
}
