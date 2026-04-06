// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
  namaTrip: json['namaTrip'] as String,
  tanggalMulai: json['tanggalMulai'] as String,
  tanggalAkhir: json['tanggalAkhir'] as String,
);

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
  'namaTrip': instance.namaTrip,
  'tanggalMulai': instance.tanggalMulai,
  'tanggalAkhir': instance.tanggalAkhir,
};
