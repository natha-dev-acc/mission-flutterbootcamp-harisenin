import 'package:json_annotation/json_annotation.dart';

part 'itennary.g.dart';

// Model ItineraryItem menyimpan aktivitas perjalanan
// 🗺️ Struktur class ItineraryItem sudah mantap dan lengkap! 
// ⚠️ Sedikit typo di penamaan file dan class: "Itennary" seharunya "Itinerary". 
// Gak masalah, ini sering kejadian kok, tinggal rename pelan-pelan ya! 😄
@JsonSerializable()
class ItineraryItem {
  final String lokasi;
  final String waktu;
  final String catatan;
  final String idTrip;

  ItineraryItem({
    required this.lokasi,
    required this.waktu,
    required this.catatan,
    required this.idTrip,
  });

  // ===== MANUAL =====
  // ✨ Fungsi Serialization manual berjalan mulus.
  Map<String, dynamic> toJsonManual() => {
        'lokasi': lokasi,
        'waktu': waktu,
        'catatan': catatan,
        'idTrip': idTrip,
      };

  factory ItineraryItem.fromJsonManual(
          Map<String, dynamic> json) =>
      ItineraryItem(
        lokasi: json['lokasi'],
        waktu: json['waktu'],
        catatan: json['catatan'],
        idTrip: json['idTrip'],
      );

  // ===== AUTO =====
  // 🧙‍♂️ Pakai JSON Generator bikin kode makin clean & safe. Good job!
  Map<String, dynamic> toJson() =>
      _$ItineraryItemToJson(this);

  factory ItineraryItem.fromJson(
          Map<String, dynamic> json) =>
      _$ItineraryItemFromJson(json);
}
