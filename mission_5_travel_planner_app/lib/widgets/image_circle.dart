import 'package:flutter/material.dart';

// Widget reusable untuk menampilkan gambar berbentuk lingkaran
// Aman di berbagai ukuran layar
// 💎 `ImageCircle` yang sangat versatile dengan `ClipOval`. 
// Memastikan avatar atau gambar sirkular selalu presisi! 🖼️✨
class ImageCircle extends StatelessWidget {
  final String imagePath;
  final double size;

  const ImageCircle({
    super.key,
    required this.imagePath,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
