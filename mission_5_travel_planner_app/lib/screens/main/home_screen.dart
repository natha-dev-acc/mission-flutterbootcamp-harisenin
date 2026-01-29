import 'package:flutter/material.dart';

import '../../styles/app_color.dart';
import '../../styles/app_fontstyle.dart';
import '../../styles/app_spacing.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/image_circle.dart';

// Home Screen (UI ONLY)
// Aman dari overflow & responsif semua ukuran layar
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 24),

            // 1. PROFIL
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageCircle(
                  imagePath: 'assets/image/home/profile.png',
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Galileo!',
                        style: AppFonts.base(
                          engine: FontEngine.inter,
                          size: 24,
                          weight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Welcome to WanderLy',
                        style: AppFonts.base(
                          engine: FontEngine.inter,
                          size: 16,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 2. DISCOVER
            Container(
              height: 126,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/image/home/discover_your_destination.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover Your Destination',
                    style: AppFonts.base(
                      engine: FontEngine.urbanist,
                      size: 24,
                      weight: FontWeight.w800,
                      style: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC9B5B5),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Book Now'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: const Text('Discover More'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. TODAY TOP RATE
            Text(
              'Today Top Rate',
              style: AppFonts.base(
                engine: FontEngine.urbanist,
                size: 24,
                weight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _TopRateCard(
                    image: 'assets/image/home/busan.png',
                    title: 'Busan, South Korea',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TopRateCard(
                    image: 'assets/image/home/bangkok.png',
                    title: 'Bangkok, Thailand',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 4. POPULAR
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'POPULAR',
                        style: AppFonts.base(
                          engine: FontEngine.inter,
                          size: 20,
                          weight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.textPrimary,
                          side: BorderSide(color: colors.textPrimary),
                        ),
                        child: const Text('Show All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // WRAP → ANTI OVERFLOW
                  Wrap(
                    spacing: 20,
                    runSpacing: 16,
                    children: const [
                      _PopularItem(
                        image: 'assets/image/home/kyoto.png',
                        title: 'Kyoto',
                      ),
                      _PopularItem(
                        image: 'assets/image/home/bali.png',
                        title: 'Bali',
                      ),
                      _PopularItem(
                        image: 'assets/image/home/new_york.png',
                        title: 'New York',
                      ),
                      _PopularItem(
                        image: 'assets/image/home/london.png',
                        title: 'London',
                      ),
                      _PopularItem(
                        image: 'assets/image/home/busan.png',
                        title: 'Busan',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// TOP RATE CARD (RESPONSIVE)
class _TopRateCard extends StatelessWidget {
  final String image;
  final String title;

  const _TopRateCard({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppFonts.base(
              engine: FontEngine.urbanist,
              size: 13,
              weight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================
// POPULAR ITEM
// =============================
class _PopularItem extends StatelessWidget {
  final String image;
  final String title;

  const _PopularItem({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageCircle(imagePath: image),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppFonts.base(
            engine: FontEngine.inter,
            size: 15,
            weight: FontWeight.w500,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
