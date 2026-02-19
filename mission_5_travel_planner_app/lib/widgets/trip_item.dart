import 'package:flutter/material.dart';
import '../styles/app_color.dart';

class TripItem extends StatelessWidget {
  final String title;
  final String subtitle;

  // === IMAGE / ICON MODE ===
  final String? imagePath;
  final IconData? leadingIcon;

  // untuk Search / Home
  final VoidCallback? onTap;

  // untuk Trip Screen
  final bool showActions;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget? bottomWidget;

// 💎 Component `TripItem` ini sangat fleksibel (Reusable). Bisa dipakai di 
// Search, Home, maupun Trip List dengan berbagai parameter mode. Mantap! 🧩✨
  const TripItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.imagePath,
    this.leadingIcon,
    this.onTap,
    this.showActions = false,
    this.onEdit,
    this.onDelete,
    this.bottomWidget,
  }) : assert(
          imagePath != null || leadingIcon != null,
          'Either imagePath or leadingIcon must be provided',
        );

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                // ===== LEFT IMAGE / ICON =====
                if (imagePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      imagePath!,
                      width: 85,
                      height: 73,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    width: 85,
                    height: 73,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: colors.background,
                    ),
                    child: Icon(
                      leadingIcon,
                      size: 36,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),

                const SizedBox(width: 12),

                // ===== TEXT =====
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== RIGHT ACTION =====
                if (!showActions && onTap != null && imagePath != null)
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),

                if (showActions) ...[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 18,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 18,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ],
            ),

            if (bottomWidget != null) ...[
              const SizedBox(height: 8),
              bottomWidget!,
            ],
          ],
        ),
      ),
    );
  }
}
