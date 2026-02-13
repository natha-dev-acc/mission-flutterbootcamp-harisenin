import 'package:sizer/sizer.dart';

// 💎 Definisi spacing berbasis `Sizer` (w unit) sangat brilian! 
// Layout akan tetap proporsional di berbagai aspek rasio layar. 📱📏
class AppSpacing {
  const AppSpacing._();

  static double get xs => 1.w;   // ~4
  static double get sm => 2.w;   // ~8
  static double get md => 4.w;   // ~16
  static double get lg => 6.w;   // ~24
  static double get xl => 8.w;   // ~32
}
