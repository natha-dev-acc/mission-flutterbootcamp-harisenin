import 'package:flutter/material.dart';

// Widget logo Wanderly agar ukuran konsisten di semua halaman
// 💎 Reusability adalah kunci. `WanderlyLogo` satu tempat untuk semua halaman 
// memastikan identitas brand tetap konsisten di seluruh aplikasi. 🎯🖼️
class WanderlyLogo extends StatelessWidget {
  const WanderlyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/image/auth/wanderly_logo.png',
      width: 297,
      height: 198,
      fit: BoxFit.contain,
    );
  }
}
