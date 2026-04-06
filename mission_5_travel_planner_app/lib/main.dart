import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'models/trip_model.dart';

import 'routes/app_routes.dart';

// Entry point aplikasi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive
  await Hive.initFlutter();

  // Register adapter Trip
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TripAdapter());
  }

  // Buka box Trip
  await Hive.openBox<Trip>('trips');

  runApp(const ProviderScope(child: WanderlyApp()));
}

// Root widget aplikasi
class WanderlyApp extends StatefulWidget {
  const WanderlyApp({super.key});

  @override
  State<WanderlyApp> createState() => _WanderlyAppState();
}

class _WanderlyAppState extends State<WanderlyApp> {
  // Mengatur mode tema (default Light Mode)
  ThemeMode _themeMode = ThemeMode.light;

  // Toggle Light / Dark Mode
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
  // Line 46:❌ Theme mode utama masih dikontrol setState pada root app.
  // Suggestion: Migrasikan theme ke Riverpod provider supaya seluruh app mengikuti satu state management pattern.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Wanderly',
          debugShowCheckedModeBanner: false,

          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: _themeMode,

          // Named Routes
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,

          // Inject theme controller
          builder: (context, child) {
            return ThemeController(
              isDark: _themeMode == ThemeMode.dark,
              toggleTheme: toggleTheme,
              child: child!,
            );
          },
        );
      },
    );
  }
}

// InheritedWidget untuk kontrol theme global
class ThemeController extends InheritedWidget {
  final bool isDark;
  final Function(bool) toggleTheme;

  const ThemeController({
    super.key,
    required this.isDark,
    required this.toggleTheme,
    required super.child,
  });

  static ThemeController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeController>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeController oldWidget) {
    return isDark != oldWidget.isDark;
  }
}
