import 'package:flutter/material.dart';
import '../styles/app_color.dart';

// Divider dengan teks "Or"
class ButtonDivider extends StatelessWidget {
  const ButtonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      children: [
        Expanded(child: Divider(color: colors.textSecondary)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Or',
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
        Expanded(child: Divider(color: colors.textSecondary)),
      ],
    );
  }
}
