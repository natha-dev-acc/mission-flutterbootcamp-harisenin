import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan untuk cek login

import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan untuk cek first launch

import 'package:sizer/sizer.dart';

import 'firebase_options.dart'; // Mengimpor file yang baru saja di-generate oleh CLI

import 'routes/app_routes.dart';
import 'presentation/providers/theme_provider.dart';

// Import Screens untuk navigasi langsung di FutureBuilder
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/main/main_shell_screen.dart';

// Entry point aplikasi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase (WAJIB untuk Auth & Firestore)
  // SEKARANG DITAMBAHKAN OPTIONS agar koneksi ke Android/Web valid
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: WanderlyApp()));
}

// Root aplikasi menggunakan ConsumerStatefulWidget agar Future hanya jalan sekali
class WanderlyApp extends ConsumerStatefulWidget {
  const WanderlyApp({super.key});

  @override
  ConsumerState<WanderlyApp> createState() => _WanderlyAppState();
}

class _WanderlyAppState extends ConsumerState<WanderlyApp> {
  late Future<Widget> _startPage;

  @override
  void initState() {
    super.initState();
    // Jalankan pengecekan hanya sekali saat aplikasi pertama kali dimuat
    _startPage = _determineStartPage();
  }

  // Fungsi internal untuk menentukan halaman mana yang harus muncul pertama kali
  Future<Widget> _determineStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('first_launch') ?? true;
    final user = FirebaseAuth.instance.currentUser;

    // Skenario 1: Jika ini instalasi pertama kali
    if (isFirstLaunch) {
      return const SplashScreen();
    }

    // Skenario 2: Jika sudah pernah buka dan posisi sudah Login
    if (user != null) {
      return const MainShellScreen();
    }

    // Skenario 3: Jika sudah pernah buka tapi posisi Logout
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    // Ambil theme mode dari Riverpod (State sekarang persist karena SharedPreferences di provider)
    final themeMode = ref.watch(themeProvider);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'WanderLy',
          debugShowCheckedModeBanner: false,

          // Light Mode
          theme: ThemeData(
            brightness: Brightness.light,
          ),

          // Dark Mode
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),

          // Theme dari provider (NO setState)
          themeMode: themeMode,

          // SOLUSI: Menggunakan FutureBuilder dengan variabel _startPage agar tidak reset saat ganti tema
          home: FutureBuilder<Widget>(
            future: _startPage, 
            builder: (context, snapshot) {
              // Menampilkan layar kosong sebentar saat sistem mengecek SharedPreferences
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: SizedBox.shrink());
              }
              // Tampilkan halaman hasil pengecekan (Splash, Login, atau Home)
              return snapshot.data ?? const SplashScreen();
            },
          ),

          // Routing tetap didaftarkan agar Navigator.pushNamed tetap bekerja
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan untuk cek login

// import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan untuk cek first launch

// import 'package:sizer/sizer.dart';

// import 'firebase_options.dart'; // Mengimpor file yang baru saja di-generate oleh CLI

// import 'routes/app_routes.dart';
// import 'presentation/providers/theme_provider.dart';

// // Import Screens untuk navigasi langsung di FutureBuilder
// import 'presentation/screens/splash_screen.dart';
// import 'presentation/screens/auth/login_screen.dart';
// import 'presentation/screens/main/main_shell_screen.dart';

// // Entry point aplikasi
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Inisialisasi Firebase (WAJIB untuk Auth & Firestore)
//   // SEKARANG DITAMBAHKAN OPTIONS agar koneksi ke Android/Web valid
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const ProviderScope(child: WanderlyApp()));
// }

// // Root aplikasi TANPA setState (pakai Riverpod)
// class WanderlyApp extends ConsumerWidget {
//   const WanderlyApp({super.key});

//   // Fungsi internal untuk menentukan halaman mana yang harus muncul pertama kali
//   Future<Widget> _determineStartPage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isFirstLaunch = prefs.getBool('first_launch') ?? true;
//     final user = FirebaseAuth.instance.currentUser;

//     // Skenario 1: Jika ini instalasi pertama kali
//     if (isFirstLaunch) {
//       return const SplashScreen();
//     }

//     // Skenario 2: Jika sudah pernah buka dan posisi sudah Login
//     if (user != null) {
//       return const MainShellScreen();
//     }

//     // Skenario 3: Jika sudah pernah buka tapi posisi Logout
//     return const LoginScreen();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Ambil theme mode dari Riverpod (State sekarang persist karena SharedPreferences di provider)
//     final themeMode = ref.watch(themeProvider);

//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//           title: 'WanderLy',
//           debugShowCheckedModeBanner: false,

//           // Light Mode
//           theme: ThemeData(
//             brightness: Brightness.light,
//           ),

//           // Dark Mode
//           darkTheme: ThemeData(
//             brightness: Brightness.dark,
//           ),

//           // Theme dari provider (NO setState)
//           themeMode: themeMode,

//           // SOLUSI: Menggunakan FutureBuilder sebagai home untuk skip Splash secara total
//           home: FutureBuilder<Widget>(
//             future: _determineStartPage(),
//             builder: (context, snapshot) {
//               // Menampilkan layar kosong sebentar saat sistem mengecek SharedPreferences
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Scaffold(body: SizedBox.shrink());
//               }
//               // Tampilkan halaman hasil pengecekan (Splash, Login, atau Home)
//               return snapshot.data ?? const SplashScreen();
//             },
//           ),

//           // Routing tetap didaftarkan agar Navigator.pushNamed tetap bekerja
//           routes: AppRoutes.routes,
//         );
//       },
//     );
//   }
// }
