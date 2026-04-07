import 'package:flutter/material.dart';
import '../../screens/trip/add_trip_screen.dart';

class TripAddButton extends StatelessWidget {
  const TripAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigasi ke screen tambah trip yang sudah kita fix tadi
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddTripScreen(),
          ),
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
