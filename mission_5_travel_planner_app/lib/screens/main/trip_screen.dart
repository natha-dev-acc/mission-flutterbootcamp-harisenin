import 'package:flutter/material.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/trip_item.dart';
import '../../widgets/square_icon.dart';

import '../crud/input_form_screen.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _trips = [
    {
      'title': 'Dramatic limestone island',
      'subtitle': 'Halong Bay, Vietnam',
      'image': 'assets/image/search/halong_bay.png',
    },
    {
      'title': 'The Iconic White and Blue',
      'subtitle': 'Santorini, Greece',
      'image': 'assets/image/search/santorini.png',
    },
  ];

  String _keyword = '';

  void _confirmDelete(String title, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text(
          'Kamu yakin ingin menghapus rencana perjalanan ke "$title"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _trips.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final filteredTrips = _trips.where((trip) {
      final q = _keyword.toLowerCase();
      return trip['title'].toLowerCase().contains(q) ||
          trip['subtitle'].toLowerCase().contains(q);
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 32),

            WanderlySearchBar(
              controller: _controller,
              placeholder: 'Search your saved destination',
              onChanged: (value) {
                setState(() {
                  _keyword = value;
                });
              },
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.separated(
                itemCount: filteredTrips.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final trip = filteredTrips[index];

                  return TripItem(
                    title: trip['title'],
                    subtitle: trip['subtitle'],
                    imagePath: trip['image'],
                    showActions: true,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InputFormScreen(),
                        ),
                      );
                    },
                    onDelete: () {
                      _confirmDelete(trip['title'], index);
                    },
                    bottomWidget: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: const [
                          SquareIcon(icon: Icons.camera_alt, label: 'Sightseeing'),
                          SquareIcon(icon: Icons.restaurant, label: 'Restaurant'),
                          SquareIcon(icon: Icons.nightlife, label: 'Nightlife'),
                          SquareIcon(icon: Icons.hotel, label: 'Hotel'),
                          SquareIcon(icon: Icons.shopping_bag, label: 'Shopping'),
                          SquareIcon(icon: Icons.movie, label: 'Cinema'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
