import 'package:flutter/material.dart';
import '../styles/app_color.dart';

class TripItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  // untuk Search / Home
  final VoidCallback? onTap;

  // untuk Trip Screen
  final bool showActions;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  final Widget? bottomWidget;

  const TripItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onTap,
    this.showActions = false,
    this.onEdit,
    this.onDelete,
    this.bottomWidget,
  });

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    imagePath,
                    width: 85,
                    height: 73,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                if (!showActions)
                  Icon(
                    Icons.arrow_forward_ios,
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

// import 'package:flutter/material.dart';
// import '../styles/app_color.dart';

// class TripItem extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String imagePath;

//   // ✅ untuk tap satu item (Search / Home)
//   final VoidCallback? onTap;

//   // ✅ untuk mode action (Trip Screen)
//   final bool showActions;
//   final VoidCallback? onEdit;
//   final VoidCallback? onDelete;

//   final Widget? bottomWidget;

//   const TripItem({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.imagePath,
//     this.onTap,
//     this.showActions = false,
//     this.onEdit,
//     this.onDelete,
//     this.bottomWidget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colors = AppColors.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return InkWell(
//       borderRadius: BorderRadius.circular(7),
//       onTap: onTap, // ✅ AMAN: null = tidak bisa diklik
//       child: Container(
//         decoration: BoxDecoration(
//           color: colors.surface,
//           borderRadius: BorderRadius.circular(7),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(7),
//                   child: Image.asset(
//                     imagePath,
//                     width: 85,
//                     height: 73,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: colors.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         subtitle,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: colors.textPrimary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 if (showActions) ...[
//                   IconButton(
//                     icon: Icon(
//                       Icons.edit,
//                       size: 18,
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                     onPressed: onEdit,
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.delete,
//                       size: 18,
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                     onPressed: onDelete,
//                   ),
//                 ],
//               ],
//             ),

//             if (bottomWidget != null) ...[
//               const SizedBox(height: 8),
//               bottomWidget!,
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../styles/app_color.dart';

// class TripItem extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String imagePath;
//   final VoidCallback onTap;

//   const TripItem({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.imagePath,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colors = AppColors.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return InkWell(
//       borderRadius: BorderRadius.circular(7),
//       onTap: onTap,
//       child: Container(
//         height: 97,
//         decoration: BoxDecoration(
//           color: colors.surface,
//           borderRadius: BorderRadius.circular(7),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(7),
//               child: Image.asset(
//                 imagePath,
//                 width: 85,
//                 height: 73,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: colors.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: colors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: isDark ? Colors.white : Colors.black,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
