import 'package:flutter/material.dart';
import '../models/itennary.dart';

class ItennaryPage extends StatefulWidget {
  const ItennaryPage({super.key});

  @override
  State<ItennaryPage> createState() => _ItennaryPageState();
}

class _ItennaryPageState extends State<ItennaryPage> {
  String output = '-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary Serialization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== MANUAL =====
            ElevatedButton(
              onPressed: () {
                final item = ItineraryItem(
                  lokasi: 'KYOTO',
                  waktu: 'JAM 8 MALAM',
                  catatan:
                      'Cobain ramen khas Ichiraku di dekat rumah Masashi Kishimoto',
                  idTrip: '1022',
                );

                // Simpan object ke JSON manual
                final json = item.toJsonManual();

                // Ambil kembali JSON menjadi object
                final obj = ItineraryItem.fromJsonManual(json);

                setState(() {
                  output =
                      'Tombol ini menjalankan SERIALISASI MANUAL.\n\n'
                      'Object → JSON:\n$json\n\n'
                      'JSON → Object:\n'
                      'Lokasi: ${obj.lokasi}\n'
                      'Waktu: ${obj.waktu}\n'
                      'Catatan: ${obj.catatan}\n'
                      'ID Trip: ${obj.idTrip}';
                });
              },
              child: const Text('RUN MANUAL'),
            ),

            const SizedBox(height: 12),

            // ===== AUTO =====
            ElevatedButton(
              onPressed: () {
                final item = ItineraryItem(
                  lokasi: 'KYOTO',
                  waktu: 'JAM 8 MALAM',
                  catatan:
                      'Cobain ramen khas Ichiraku di dekat rumah Masashi Kishimoto',
                  idTrip: '1022',
                );

                // json_serializable mengubah object otomatis
                final json = item.toJson();
                final obj = ItineraryItem.fromJson(json);

                setState(() {
                  output =
                      'Tombol ini menjalankan SERIALISASI OTOMATIS.\n\n'
                      'json_serializable bekerja sebagai translator\n'
                      'antara Object dan JSON.\n\n'
                      'Hasil Object:\n'
                      'Lokasi: ${obj.lokasi}\n'
                      'Waktu: ${obj.waktu}\n'
                      'Catatan: ${obj.catatan}\n'
                      'ID Trip: ${obj.idTrip}';
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
