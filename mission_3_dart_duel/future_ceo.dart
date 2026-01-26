class BankAccount {
  String namaPemilik;
  double saldo;

  BankAccount({
    required this.namaPemilik,
    required this.saldo,
  });

  void setor(double jumlah) {
    saldo += jumlah;
    // 💡 Note: Instruksi meminta pesan "Sukses! Saldo tersisa: Rp...".
    // Sebaiknya tampilkan saldo akhir agar user tahu uangnya bertambah.
    print('Saldo tunai: Rp $jumlah -> Sukses!');
  }

  void tarik(double jumlah) {
    if (jumlah > saldo) {
      double kurang = jumlah - saldo;
      print('⚠ GAGAL: Maaf, saldo kamu kurang Rp $kurang lagi nih!');
    }
    // 🔴 Critical: Wah, logic else-nya ketinggalan nih! 
    // Kalau saldonya cukup, belum ada logic untuk mengurangi saldo dan menampilkan pesan sukses.
    // Jangan lupa tambahkan:
    // else {
    //   saldo -= jumlah;
    //   print('Sukses! Saldo tersisa: Rp $saldo');
    // }
  }
}

void main() {
  var nasabah = BankAccount(
    namaPemilik: 'MR STARK',
    saldo: 1000000.0,
  );

  print('💰 Halo ${nasabah.namaPemilik}!');
  print('Saldo awal: Rp ${nasabah.saldo}');

  nasabah.setor(500000.0);
  print('Saldo sekarang: Rp ${nasabah.saldo}');

  nasabah.tarik(2000000.0);

  // 💡 Tips: Coba tambahkan satu case lagi untuk penarikan berhasil 
  // untuk memastikan logic else-nya berjalan dengan benar.
  // nasabah.tarik(100000.0); 
}
