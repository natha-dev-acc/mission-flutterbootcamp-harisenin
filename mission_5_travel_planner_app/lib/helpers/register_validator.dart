// 💎 Validasi untuk registrasi di sini sangat lengkap, termasuk konfirmasi password. 
// User experience jadi lebih aman dengan pengecekan mendalam seperti ini! 🔐🏆
class RegisterValidator {
  // Validasi Full Name
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full Name wajib diisi';
    }
    return null;
  }

  // Validasi Email (re-use logic Login)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // Validasi Phone
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'No. HP wajib diisi';
    }
    return null;
  }

  // Validasi Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // Validasi Konfirmasi Password
  static String? validateConfirmPassword(
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (value != password) {
      return 'Password tidak sama';
    }
    return null;
  }
}
