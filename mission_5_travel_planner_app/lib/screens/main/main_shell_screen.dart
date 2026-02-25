import 'package:flutter/material.dart';

import '../../widgets/bottom_navbar.dart';
import '../../styles/app_color.dart';

import 'home_screen.dart';
import 'search_screen.dart';
import 'trip_screen.dart';
import 'profile_screen.dart';

// 💎 `MainShellScreen` yang mengelola navigasi antar tab dengan sangat bersih. 
// Penggunaan `IndexedStack` (atau list indexing) adalah cara standar yang solid! 🗂️⚡
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    TripScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,

      body: SafeArea(
        child: _screens[_currentIndex],
      ),

      bottomNavigationBar: WanderlyBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
