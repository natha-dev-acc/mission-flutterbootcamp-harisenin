class BankAccount {
  String namaPemilik;
  double saldo;

  BankAccount({
    required this.namaPemilik,
    required this.saldo,
  });

  void setor(double jumlah) {
    saldo += jumlah;
    print('Saldo tunai: Rp $jumlah -> Sukses!');
  }

  void tarik(double jumlah) {
    if (jumlah > saldo) {
      double kurang = jumlah - saldo;
      print('⚠ GAGAL: Maaf, saldo kamu kurang Rp $kurang lagi nih!');
    }
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
}
