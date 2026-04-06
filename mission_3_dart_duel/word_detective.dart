void main() {
  String kata = "Katak";
  String kataKecil = kata.toLowerCase();
  String kataBalik = kataKecil.split("").reversed.join("");
  
  bool isPalindrome = kataKecil == kataBalik;

  int jumlahVokal = 0;
  List<String> vokal = ['a', 'i', 'u', 'e', 'o'];

  for (var huruf in kataKecil.split("")) {
    if (vokal.contains(huruf)) {
      jumlahVokal++;
    }
  }

  print('🔤 Analisis Kata: "$kata"');
  print('- Status Palindrome: ${isPalindrome ? "IYA!" : "TIDAK"}');
  print('- Jumlah Huruf Vokal: ${jumlahVokal}');
}
