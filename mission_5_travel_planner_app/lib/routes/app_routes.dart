import 'package:flutter/material.dart';

// Screens (sudah pindah ke presentation layer)
import '../presentation/screens/splash_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/main/main_shell_screen.dart';

// Kumpulan Named Routes aplikasi
class AppRoutes {
  // Route name constants
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  // Mapping route ke halaman
  static Map<String, WidgetBuilder> routes = {
    // Splash Screen (akan handle redirect otomatis)
    splash: (context) => const SplashScreen(),

    // Auth
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),

    // Main App (setelah login)
    home: (context) => const MainShellScreen(),
  };
}