import 'package:flutter/material.dart';

import '../../widgets/wanderly_logo.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/trip_item.dart';

import '../crud/detail_trip_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> _allTrips = [
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
    {
      'title': 'Iconic Urban Energy',
      'subtitle': 'New York, USA',
      'image': 'assets/image/search/new_york.png',
    },
    {
      'title': 'Nature, Culture and Beach',
      'subtitle': 'Bali, Indonesia',
      'image': 'assets/image/search/bali.png',
    },
    {
      'title': 'Golden Pavilion',
      'subtitle': 'Kyoto, Japan',
      'image': 'assets/image/search/kyoto.png',
    },
  ];

  String _keyword = '';

  @override
  Widget build(BuildContext context) {

    final filteredTrips = _allTrips.where((trip) {
      final q = _keyword.toLowerCase();
      return trip['title']!.toLowerCase().contains(q) ||
          trip['subtitle']!.toLowerCase().contains(q);
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
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final trip = filteredTrips[index];
                  return TripItem(
                    title: trip['title']!,
                    subtitle: trip['subtitle']!,
                    imagePath: trip['image']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DetailTripScreen(),
                        ),
                      );
                    },
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
