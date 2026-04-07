import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/styles/app_spacing.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/home_screen/profile_header.dart';
import '../../widgets/home_screen/map_with_carousel.dart';

// Home Screen (UI ONLY + Dynamic User)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 24),

            // ===== PROFILE HEADER =====
            const ProfileHeader(),

            const SizedBox(height: 24),

            // ================= MAP + CAROUSEL =================
            const MapWithCarousel(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../core/styles/app_color.dart';
// import '../../../core/styles/app_fontstyle.dart';
// import '../../../core/styles/app_spacing.dart';

// import '../../widgets/wanderly_logo.dart';
// import '../../widgets/image_circle.dart';
// import '../../widgets/home_screen/profile_header.dart';
// import '../../widgets/home_screen/map_with_carousel.dart';

// import '../../providers/auth_provider.dart';

// // Home Screen (UI ONLY + Dynamic User)
// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final colors = AppColors.of(context);

//     final authState = ref.watch(authProvider);
//     final user = authState.user;

//     final fullName = user?.displayName ?? 'Traveler';

//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             const Center(child: WanderlyLogo()),
//             const SizedBox(height: 24),

//             // ===== PROFILE HEADER =====
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const ImageCircle(
//                   imagePath: 'assets/image/home/profile.png',
//                 ),
//                 SizedBox(width: AppSpacing.sm),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hi, $fullName!',
//                         style: AppFonts.base(
//                           engine: FontEngine.inter,
//                           size: 24,
//                           weight: FontWeight.w600,
//                           color: colors.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Welcome to WanderLy Travel Planner App!!',
//                         style: AppFonts.base(
//                           engine: FontEngine.inter,
//                           size: 16,
//                           color: colors.textPrimary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // ================= MAP + CAROUSEL =================
//             const MapWithCarousel(),

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }