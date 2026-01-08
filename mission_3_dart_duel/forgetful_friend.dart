void main() {
  int tahunSekarang = 2026;
  int bulanSekarang = DateTime.now().month;
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
      'ultah': null, // data tidak lengkap
    },
  ];

  print('📅 DAFTAR ULANG TAHUN BULAN JANUARI:');

  int total = 0;
  int nomor = 1;

  for (var data in teman) {
    String nama = data['nama'];
    String? ultah = data['ultah'];

    if (ultah == null || ultah.isEmpty) {
      print('- Data $nama tidak lengkap, dilewati...');
      continue;
    }

    List<String> parts = ultah.split('-');
    int tahunLahir = int.parse(parts[0]);
    int bulanLahir = int.parse(parts[1]);

    if (bulanLahir == bulanSekarang) {
      int umur = tahunSekarang - tahunLahir;

      print(
        '$nomor. Risers $nama: Wah, lagi ultah nih! Umurnya sekarang $umur tahun.',
      );

      nomor++;
      total++;
    }
  }

  print('-------------------------------------------');
  print('(Total ada $total teman yang harus kamu hubungi!)');
}
