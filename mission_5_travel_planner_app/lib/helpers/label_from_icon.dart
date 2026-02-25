import 'package:flutter/material.dart';

// 💎 Mapping icon ke label ini sangat cerdas untuk memastikan konsistensi 
// antara data dan apa yang ditampilkan di UI. Sangat modular! 🏷️🎯
String labelFromIcon(IconData icon) {
  switch (icon) {
    case Icons.camera_alt:
      return 'Sightseeing';
    case Icons.restaurant:
      return 'Restaurant';
    case Icons.nightlife:
      return 'Nightlife';
    case Icons.hotel:
      return 'Hotel';
    case Icons.shopping_bag:
      return 'Shopping';
    case Icons.movie:
      return 'Cinema';
    default:
      return '';
  }
}
