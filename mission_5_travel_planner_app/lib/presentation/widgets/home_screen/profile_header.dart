import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/styles/app_color.dart';
import '../../../core/styles/app_fontstyle.dart';
import '../../../core/styles/app_spacing.dart';

import '../../widgets/image_circle.dart';

import '../../providers/auth_provider.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    
    // Mengambil data user langsung di dalam widget ini
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final fullName = user?.displayName ?? 'Traveler';

    return Row(
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
                'Hi, $fullName!',
                style: AppFonts.base(
                  engine: FontEngine.inter,
                  size: 24,
                  weight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Welcome to WanderLy Travel Planner App!!',
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
    );
  }
}
