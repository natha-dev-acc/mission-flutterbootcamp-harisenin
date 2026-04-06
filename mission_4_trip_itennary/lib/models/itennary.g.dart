// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itennary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryItem _$ItineraryItemFromJson(Map<String, dynamic> json) =>
    ItineraryItem(
      lokasi: json['lokasi'] as String,
      waktu: json['waktu'] as String,
      catatan: json['catatan'] as String,
      idTrip: json['idTrip'] as String,
    );

Map<String, dynamic> _$ItineraryItemToJson(ItineraryItem instance) =>
    <String, dynamic>{
      'lokasi': instance.lokasi,
      'waktu': instance.waktu,
      'catatan': instance.catatan,
      'idTrip': instance.idTrip,
    };
