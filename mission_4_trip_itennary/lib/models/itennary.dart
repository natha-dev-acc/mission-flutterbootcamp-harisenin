import 'package:json_annotation/json_annotation.dart';

part 'itennary.g.dart';

// Model ItineraryItem menyimpan aktivitas perjalanan
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
  Map<String, dynamic> toJson() =>
      _$ItineraryItemToJson(this);

  factory ItineraryItem.fromJson(
          Map<String, dynamic> json) =>
      _$ItineraryItemFromJson(json);
}
