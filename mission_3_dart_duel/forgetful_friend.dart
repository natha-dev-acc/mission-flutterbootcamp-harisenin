void main() {
  int tahunSekarang = 2026; // ✅ Sesuai arahan soal: gunakan tahun sekarang sebagai 2026
  int bulanSekarang = DateTime.now().month; // ✅ Mengambil bulan saat ini dengan DateTime.now()

  // ✅ List teman sudah dibuat dengan minimal 3 data
  // ⚠️ Catatan: sudah ada satu data ultah null, sesuai instruksi
  List<Map<String, dynamic>> teman = [
    {
      'nama': 'Budi',
      'ultah': '2000-01-15',
    },
    {
      'nama': 'Siti',
      'ultah': '2005-01-20',
    },
    {
      'nama': 'Andi',
      'ultah': null, // ✅ Data tidak lengkap, sudah diuji
    },
  ];

  print('📅 DAFTAR ULANG TAHUN BULAN JANUARI:'); // ⚠️ Hardcode "JANUARI" padahal bulan bisa berbeda; bisa diganti dinamis menggunakan bulanSekarang

  int total = 0; // ✅ Counter untuk total teman yang ultah bulan ini
  int nomor = 1; // ✅ Penomoran teman

  for (var data in teman) { // ✅ Perulangan menggunakan for
    String nama = data['nama'];
    String? ultah = data['ultah'];

    // ✅ Cek data kosong/null sebelum mengolah tanggal
    if (ultah == null || ultah.isEmpty) {
      print('- Data $nama tidak lengkap, dilewati...');
      continue;
    }

    // ✅ Mengambil tahun dan bulan dari string tanggal lahir
    List<String> parts = ultah.split('-');
    int tahunLahir = int.parse(parts[0]);
    int bulanLahir = int.parse(parts[1]);

    if (bulanLahir == bulanSekarang) { // ✅ Memfilter teman yang ultah bulan ini
      int umur = tahunSekarang - tahunLahir; // ✅ Menghitung umur

      // ✅ Menampilkan output sesuai format soal
      print(
        '$nomor. Risers $nama: Wah, lagi ultah nih! Umurnya sekarang $umur tahun.',
      );

      nomor++; // ✅ Increment nomor untuk setiap teman yang cocok
      total++; // ✅ Increment total teman
    }
  }

  print('-------------------------------------------');
  print('(Total ada $total teman yang harus kamu hubungi!)'); // ✅ Output total teman
}
