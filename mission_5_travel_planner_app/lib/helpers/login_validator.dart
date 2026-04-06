class LoginValidator {
  // Validasi email: tidak kosong dan format email sederhana --> ubah Validasinya biar cek email valid yang udah register ke FireBase
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

    // Pastikan Email memang sudah register (ada di FireBase)

    // Jika lolos validasi
    return null;
  }
}
