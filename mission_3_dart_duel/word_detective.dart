void main() {
  String kata = "Katak";
  String kataKecil = kata.toLowerCase();
  String kataBalik = kataKecil.split("").reversed.join("");
  
  bool isPalindrome = kataKecil == kataBalik;
  // ✅ Good Job! Logic palindrome-nya sudah tepat dan efisien.


  int jumlahVokal = 0;
  List<String> vokal = ['a', 'i', 'u', 'e', 'o'];

  for (var huruf in kataKecil.split("")) {
    if (vokal.contains(huruf)) {
      jumlahVokal++;
    }
  }
  // 💡 Tips: Loop ini sudah benar. Alternatif lain bisa pakai .where() kalau mau lebih functional style:
  // jumlahVokal = kataKecil.split('').where((c) => vokal.contains(c)).length;


  print('🔤 Analisis Kata: "$kata"');
  print('- Status Palindrome: ${isPalindrome ? "IYA!" : "TIDAK"}');
  print('- Jumlah Huruf Vokal: ${jumlahVokal}');
  
  // 🌟 Excellent: Output sudah sesuai format dan informatif. Keep it up!
}
