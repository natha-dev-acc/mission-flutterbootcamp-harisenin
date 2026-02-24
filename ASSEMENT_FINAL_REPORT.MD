# Assessment Mission 6 🚀 Wanderly

Halo student HSB-1022! 👋  

Terima kasih sudah menyelesaikan Mission 6 pada Bootcamp Flutter Batch 1.

Implementasi sudah fungsional untuk CRUD + persistence, tetapi standar mission belum terpenuhi penuh karena `setState` masih dipakai di banyak screen dan error handling data layer masih minim.

---

## 📊 Aspek Penilaian

| Aspek Penilaian | Detail Item Penilaian | Poin Maksimal |
|-----------------|----------------------|---------------|
| Feature Completeness | Semua fitur sesuai instruction | 20 |
| Riverpod Implementation | StateNotifier/Notifier usage, state flow | 15 |
| Hive Integration | Persistensi data & adapter | 15 |
| Architecture & Structure | Separation of concerns | 15 |
| Clean Code | Naming, readability, modularity | 10 |
| Error Handling | Try-catch, fallback state | 10 |
| UI States | Loading, Empty, Error state | 10 |
| Maintainability | Scalability & structure | 5 |

---

## 📝 Raport Skor

| Aspek Penilaian | Skor Dicapai | Komentar Ramah & Kritis |
|-----------------|-------------|--------------------------|
| Feature Completeness | 18/20 | CRUD, Hive, dan konfirmasi delete ada; tetapi kepatuhan penuh “tanpa setState” belum tercapai. |
| Riverpod Implementation | 13/15 | Provider untuk trip sudah berjalan, namun masih pakai `legacy` API dan banyak state dikelola manual di UI. |
| Hive Integration | 14/15 | Adapter + box sudah benar, auto-save bekerja. |
| Architecture & Structure | 14/15 | Struktur folder cukup rapi (`screens/providers/services/models`). |
| Clean Code | 8/10 | Ada komentar berlebih/noisy dan style campuran yang menurunkan keterbacaan. |
| Error Handling | 7/10 | Operasi Hive tidak dibungkus fail-safe handling di service/provider. |
| UI States | 8/10 | Loading dan empty state ada; error state eksplisit belum konsisten. |
| Maintainability | 4/5 | Dasar maintainable sudah baik, tapi ketergantungan pola campuran membuat refactor berikutnya lebih berat. |

**Total Skor: 86 / 100 🎯**

---

## 2️⃣ Temuan Detail per File

### ✅ Hal yang Sudah Bagus
- `lib/providers/trip_provider.dart` sudah memindahkan operasi CRUD ke notifier.
- `lib/main.dart` sudah menginisialisasi Hive sebelum `runApp`.
- `lib/screens/main/trip_screen.dart` sudah punya loading state dan delete confirmation.

### ⚠️ Perlu Peningkatan
- `lib/providers/trip_provider.dart` masih menggunakan `flutter_riverpod/legacy.dart`.
- `lib/screens/main/trip_screen.dart` masih mengandalkan `setState` untuk filtering, melanggar ketentuan mission yang ketat.
- `lib/services/trip_service.dart` belum memiliki proteksi error handling saat operasi box.

---

## 3️⃣ Inline Review Simulation

lib/providers/trip_provider.dart

Line 1:  
❌ Provider masih import `flutter_riverpod/legacy.dart`.
Suggestion: Pindahkan ke API Riverpod modern (`flutter_riverpod/flutter_riverpod.dart`) agar konsisten dengan standar Notifier saat ini.

Severity: Medium  
Impact: Menambah technical debt dan memperumit upgrade dependency.

lib/screens/main/trip_screen.dart

Line 89:  
❌ Filtering keyword masih dikelola dengan `setState` langsung di screen.
Suggestion: Pindahkan state pencarian ke provider (`StateProvider<String>`) lalu derive filtered list secara reaktif.

Severity: Medium  
Impact: Separation of concerns kurang bersih, dan state flow jadi tersebar.

lib/services/trip_service.dart

Line 55:  
❌ Operasi `putAt`/`deleteAt` tidak dibungkus validasi index dan handling exception.
Suggestion: Tambahkan try-catch + guard index agar UI tidak crash saat data berubah bersamaan.

Severity: High  
Impact: Berisiko memunculkan runtime exception dan kehilangan kepercayaan user.

lib/main.dart

Line 46:  
❌ Theme mode utama masih dikontrol `setState` pada root app.
Suggestion: Migrasikan theme ke Riverpod provider supaya seluruh app mengikuti satu state management pattern.

Severity: Low  
Impact: Pola state campuran menurunkan konsistensi arsitektur.

---

## 💡 Saran Pengembangan Berikutnya

1. Migrasikan semua state non-ephemeral (termasuk search/theme) ke provider agar tidak ada `setState` untuk state aplikasi.
2. Tambahkan error state UI terstruktur ketika operasi Hive gagal.
3. Ganti import Riverpod legacy dan rapikan komentar agar codebase lebih production-ready.

---

## 🧠 Kesimpulan Teknis

Project sudah memenuhi fondasi mission (Riverpod + Hive + CRUD), namun belum sepenuhnya patuh terhadap prinsip mission yang menuntut state flow terpusat di provider tanpa pola campuran `setState` pada state aplikasi.
