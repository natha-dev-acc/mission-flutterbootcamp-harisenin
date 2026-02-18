import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

// Model Trip adalah jembatan antara
// Object di memori ↔ JSON (teks)
// 🏗️ Model Trip sudah sangat baik! 
// 💡 Saran: Menggunakan data type DateTime untuk tanggal akan lebih memudahkan operasi waktu nanti,
// tapi untuk saat ini String sudah sesuai instruksi. Keren!
@JsonSerializable()
class Trip {
  final String namaTrip;
  final String tanggalMulai;
  final String tanggalAkhir;

  Trip({
    required this.namaTrip,
    required this.tanggalMulai,
    required this.tanggalAkhir,
  });

  // ===== MANUAL =====
  // Simpan object ke JSON secara manual
  // 🎯 Mantap! Implementasi manual ini dasar penting sebelum pakai generator.
  Map<String, dynamic> toJsonManual() => {
        'namaTrip': namaTrip,
        'tanggalMulai': tanggalMulai,
        'tanggalAkhir': tanggalAkhir,
      };

  // Ambil JSON lalu buat object Trip secara manual
  factory Trip.fromJsonManual(Map<String, dynamic> json) => Trip(
        namaTrip: json['namaTrip'],
        tanggalMulai: json['tanggalMulai'],
        tanggalAkhir: json['tanggalAkhir'],
      );

  // ===== AUTO (json_serializable) =====
  // 🚀 Luar biasa! Kamu sudah selangkah lebih maju dengan menggunakan json_serializable. 
  // Ini sangat membantu di project besar agar terhindar dari typos.
  Map<String, dynamic> toJson() => _$TripToJson(this);

  // Ambil JSON lalu ubah ke object otomatis
  factory Trip.fromJson(Map<String, dynamic> json) =>
      _$TripFromJson(json);
}
