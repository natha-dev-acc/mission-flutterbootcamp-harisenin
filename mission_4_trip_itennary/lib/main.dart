import 'package:flutter/material.dart';

import 'pages/trip_page.dart';
import 'pages/itennary_page.dart';

import 'models/trip.dart';

void main() {
  // UJI COBA SESUAI INSTRUKSI TUGAS

  // Membuat 1 object Trip di memori
  final trip = Trip(
    namaTrip: 'LIBURAN JEPANG 2026',
    tanggalMulai: '12 Januari 2026',
    tanggalAkhir: '28 Januari 2026',
  );

  // Mengubah object menjadi JSON (teks)
  final jsonTrip = trip.toJson();

  // Cetak JSON ke konsol (debug console)
  print('=== OBJECT → JSON ===');
  print(jsonTrip);

  // Mengambil data JSON lalu mengubahnya kembali menjadi object
  final tripFromJson = Trip.fromJson(jsonTrip);

  // Cetak hasil object hasil deserialisasi
  print('=== JSON → OBJECT ===');
  print('Nama Trip: ${tripFromJson.namaTrip}');
  print('Tanggal Mulai: ${tripFromJson.tanggalMulai}');
  print('Tanggal Akhir: ${tripFromJson.tanggalAkhir}');

  // MENJALANKAN APLIKASI FLUTTER
  runApp(const MyApp());
}

// Root aplikasi
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  // Daftar halaman utama aplikasi
  final pages = const [
    TripPage(),
    ItennaryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.flight),
              label: 'Trip',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Itinerary',
            ),
          ],
        ),
      ),
    );
  }
}
