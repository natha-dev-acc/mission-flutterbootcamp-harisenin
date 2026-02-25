import 'package:flutter/material.dart';

// 💎 Penggunaan `FittedBox` di dalam button adalah penyelamat dari 
// text overflow. Ini adalah detail kecil yang berdampak besar pada kualitas! 🛡️🎨
class SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 141,
      height: 43,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1865F5),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Urbanist',
            ),
          ),
        ),
      ),
    );
  }
}
