import 'package:flutter/material.dart';
import '../styles/app_color.dart';

// Widget indikator bawah seperti di iOS
class HomeIndicator extends StatelessWidget {
  const HomeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      height: 34,
      color: colors.primary,
      alignment: Alignment.center,
      child: Container(
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
