import 'package:flutter/material.dart';
import '../../widgets/wanderly_logo.dart';
import '../../styles/app_color.dart';

class DetailTripScreen extends StatelessWidget {
  const DetailTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Detail Trip Screen',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
