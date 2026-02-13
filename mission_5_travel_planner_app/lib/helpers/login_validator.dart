// 💎 Pemisahan logika validasi ke dalam class static `LoginValidator` 
// adalah praktik clean code yang sangat baik untuk reusability! 🛡️✨
// 💎 Penggunaan `RegExp` untuk validasi email adalah praktik standar yang sangat baik. 
// Memastikan data yang masuk ke sistem selalu valid! 🛡️⚡
class LoginValidator {
  // Validasi email: tidak kosong dan format email sederhana
  static String? validateEmail(String value) {
    // Pastikan field tidak kosong
    if (value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    // Regex sederhana untuk validasi email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    // Jika lolos validasi
    return null;
  }
}
