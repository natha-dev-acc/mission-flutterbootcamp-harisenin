import 'package:flutter/material.dart';

import '../styles/app_fontstyle.dart';

// 💎 `Footer` yang sangat komprehensif! Detail alamat, social icons, 
// dan link perusahaan membuat aplikasi terasa sangat profesional. 🏢🌐
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 438,
        minHeight: 467,
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== LOGO =====
          Image.asset(
            'assets/image/auth/wanderly_logo.png',
            width: 170,
            height: 116,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),

          // ===== TAGLINE =====
          Text(
            'Enjoy your trip with glorious serve from harijumat.co!',
            style: AppFonts.base(
              engine: FontEngine.urbanist,
              size: 20,
              weight: FontWeight.w700, // Bold
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 16),

          // ===== ADDRESS =====
          Text(
            'Jl. Raya Pajajaran No.88, Kel. Tanah Sareal, '
            'Kec. Bogor Tengah, Kota Bogor, Jawa Barat, 16127, Indonesia',
            style: AppFonts.base(
              engine: FontEngine.urbanist,
              size: 16,
              weight: FontWeight.w400,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // ===== PHONE =====
          Text(
            '+62-891827-23293',
            style: AppFonts.base(
              engine: FontEngine.urbanist,
              size: 16,
              weight: FontWeight.w400,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          // ===== PERUSAHAAN =====
          const _FooterLink(title: 'Perusahaan'),

          const SizedBox(height: 12),

          // ===== KOMUNITAS =====
          const _FooterLink(title: 'Komunitas'),

          const SizedBox(height: 16),

          // ===== DIVIDER =====
          Center(
            child: Container(
              width: 371,
              height: 1,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          // ===== SOCIAL ICONS =====
          Row(
            children: const [
              _SocialIcon(icon: Icons.work), // LinkedIn
              SizedBox(width: 16),
              _SocialIcon(icon: Icons.camera_alt), // Instagram
              SizedBox(width: 16),
              _SocialIcon(icon: Icons.close), // Twitter / X
              SizedBox(width: 16),
              _SocialIcon(icon: Icons.facebook),
            ],
          ),

          const SizedBox(height: 32),

          // ===== COPYRIGHT =====
          Text(
            '@2026 Kwetiau Siram All Rights Reserved',
            style: AppFonts.base(
              engine: FontEngine.urbanist,
              size: 16,
              weight: FontWeight.w600, // SemiBold
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== SUB WIDGETS =====

class _FooterLink extends StatelessWidget {
  final String title;

  const _FooterLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppFonts.base(
              engine: FontEngine.urbanist,
              size: 16,
              weight: FontWeight.w700, // Bold
              color: Colors.black,
            ),
          ),
        ),
        const Icon(
          Icons.arrow_forward,
          size: 16,
          color: Colors.black,
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
      ),
      child: Icon(
        icon,
        size: 28,
        color: Colors.black,
      ),
    );
  }
}
