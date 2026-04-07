// Utility validator global (Clean Architecture)
// Menggantikan helpers/login_validator.dart

class Validators {
  // ===== FULL NAME =====
  static String? validateFullName(String value) {
    if (value.trim().isEmpty) {
      return 'Nama tidak boleh kosong';
    }

    if (value.trim().length < 3) {
      return 'Nama minimal 3 karakter';
    }

    return null;
  }

  // ===== EMAIL =====
  static String? validateEmail(String value) {
    if (value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // ===== PASSWORD (WAJIB UNTUK FIREBASE) =====
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }
}