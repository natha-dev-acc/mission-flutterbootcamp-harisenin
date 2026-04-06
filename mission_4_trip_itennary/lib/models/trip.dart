import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

// Model Trip adalah jembatan antara
// Object di memori ↔ JSON (teks)
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
  // Simpan object ke JSON secara otomatis
  Map<String, dynamic> toJson() => _$TripToJson(this);

  // Ambil JSON lalu ubah ke object otomatis
  factory Trip.fromJson(Map<String, dynamic> json) =>
      _$TripFromJson(json);
}
