import 'package:flutter/material.dart';
import '../../../styles/app_color.dart';
import '../../../styles/app_fontstyle.dart';

class TripTitle extends StatelessWidget {
  const TripTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your Trips',
          style: AppFonts.base(
            engine: FontEngine.inter,
            size: 22,
            weight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
