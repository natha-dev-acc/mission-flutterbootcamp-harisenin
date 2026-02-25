import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// File hasil generate Hive adapter
part 'trip_model.g.dart';

// Model Trip sebagai entity data
// HiveType digunakan agar data bisa disimpan ke local storage
// 💎 Integrasi Hive dengan `@HiveType` dan `@HiveField` di model ini 
// menunjukkan pemahaman yang sangat mendalam tentang data persistence! 📦🧠
@HiveType(typeId: 0)
class Trip {
  // Judul trip
  @HiveField(0)
  final String title;

  // Subjudul / lokasi trip
  @HiveField(1)
  final String subtitle;

  // Path gambar
  @HiveField(2)
  final String image;

  // Aktivitas yang dipilih user
  // Tidak disimpan langsung sebagai IconData di Hive
  @HiveField(3)
  final List<int> activityCodes;

  Trip({
    required this.title,
    required this.subtitle,
    required this.image,
    List<int>? activityCodes,
  }) : activityCodes = activityCodes ?? [];

  // Helper untuk konversi ke Set<IconData> (dipakai UI)
  Set<IconData> get activities =>
      activityCodes.map((code) => IconData(code, fontFamily: 'MaterialIcons')).toSet();

  // Helper untuk membuat Trip baru dari IconData
  Trip copyWithActivities(Set<IconData> icons) {
    return Trip(
      title: title,
      subtitle: subtitle,
      image: image,
      activityCodes: icons.map((icon) => icon.codePoint).toList(),
    );
  }
}


// import 'package:flutter/material.dart';

// class Trip {
//   final String title;
//   final String subtitle;
//   final String image;
//   Set<IconData> activities;

//   Trip({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     Set<IconData>? activities,
//   }) : activities = activities ?? {};
// }
