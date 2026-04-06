import 'package:flutter/material.dart';
import '../styles/app_color.dart';

// Tombol umum untuk Continue, Google, dan Apple
class ContinueButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final VoidCallback? onPressed;

  const ContinueButton({
    super.key,
    required this.text,
    this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SizedBox(
      width: 327,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              Image.asset(iconPath!, width: 20, height: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
