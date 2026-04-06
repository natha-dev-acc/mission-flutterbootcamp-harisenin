import 'package:flutter/material.dart';
import '../models/trip.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  String output = '-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Serialization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== MANUAL =====
            ElevatedButton(
              onPressed: () {
                final trip = Trip(
                  namaTrip: 'LIBURAN JEPANG 2026',
                  tanggalMulai: '12 Januari 2026',
                  tanggalAkhir: '28 Januari 2026',
                );

                // Ubah object ke JSON secara manual
                final json = trip.toJsonManual();

                // Ambil kembali JSON menjadi object
                final obj = Trip.fromJsonManual(json);

                setState(() {
                  output =
                      'Tombol ini menjalankan SERIALISASI MANUAL.\n\n'
                      'Object → JSON:\n$json\n\n'
                      'JSON → Object:\n'
                      'Nama Trip: ${obj.namaTrip}\n'
                      'Tanggal Mulai: ${obj.tanggalMulai}\n'
                      'Tanggal Akhir: ${obj.tanggalAkhir}';
                });
              },
              child: const Text('RUN MANUAL'),
            ),

            const SizedBox(height: 12),

            // ===== AUTO =====
            ElevatedButton(
              onPressed: () {
                final trip = Trip(
                  namaTrip: 'LIBURAN JEPANG 2026',
                  tanggalMulai: '12 Januari 2026',
                  tanggalAkhir: '28 Januari 2026',
                );

                // json_serializable mengubah object otomatis
                final json = trip.toJson();
                final obj = Trip.fromJson(json);

                setState(() {
                  output =
                      'Tombol ini menjalankan SERIALISASI OTOMATIS.\n\n'
                      'json_serializable bertindak sebagai translator\n'
                      'antara Object di memori dan JSON (teks).\n\n'
                      'Hasil Object:\n'
                      'Nama Trip: ${obj.namaTrip}\n'
                      'Tanggal Mulai: ${obj.tanggalMulai}\n'
                      'Tanggal Akhir: ${obj.tanggalAkhir}';
                });
              },
              child: const Text('RUN AUTO'),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                child: Text(output),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
