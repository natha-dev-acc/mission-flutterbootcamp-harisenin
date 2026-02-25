import 'package:flutter/material.dart';

import '../../styles/app_color.dart';
import '../../widgets/footer.dart';

// 💎 `DetailTripScreen` dengan visual header image yang besar (380px) memberikan kesan 
// premium dan imersif. Tipografi Urbanist benar-benar menonjol di sini! 🎨🏞️
class DetailTripScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const DetailTripScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== IMAGE HEADER =====
              Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 380,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 33,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 24,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Detail',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Embark on a tranquil journey to Japan’s iconic Kinkaku-ji '
                  'Temple, also known as the Golden Pavilion. Set against the '
                  'serene backdrop of Kyoto’s lush gardens and calm ponds, '
                  'this Zen Buddhist temple radiates golden beauty and deep '
                  'historical and spiritual significance.',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ===== FOOTER =====
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
