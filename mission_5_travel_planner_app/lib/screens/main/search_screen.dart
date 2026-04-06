import 'package:flutter/material.dart';

import '../../models/trip_model.dart';

import '../../services/trip_service.dart';

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
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final List<Trip> filteredTrips = TripService.allTrips.where((trip) {
      final q = _keyword.toLowerCase();
      return trip.title.toLowerCase().contains(q) ||
          trip.subtitle.toLowerCase().contains(q);
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Center(child: WanderlyLogo()),
            const SizedBox(height: 32),

            WanderlySearchBar(
              controller: _controller,
              onChanged: (value) {
                setState(() => _keyword = value);
              },
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.separated(
                itemCount: filteredTrips.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final Trip trip = filteredTrips[index];

                  return TripItem(
                    title: trip.title,
                    subtitle: trip.subtitle,
                    imagePath: trip.image,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailTripScreen(
                            title: trip.title,
                            subtitle: trip.subtitle,
                            imagePath: trip.image,
                          ),
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
