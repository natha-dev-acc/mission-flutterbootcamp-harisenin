import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Pastikan import ini sesuai dengan struktur folder Anda
import '../../providers/trip_provider.dart';

class MapWithCarousel extends ConsumerStatefulWidget {
  const MapWithCarousel({super.key});

  @override
  ConsumerState<MapWithCarousel> createState() => _MapWithCarouselState();
}

class _MapWithCarouselState extends ConsumerState<MapWithCarousel> {
  GoogleMapController? _mapController;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trips = ref.watch(tripProvider).trips;

    if (trips.isEmpty) {
      return const Center(child: Text("Belum ada trip"));
    }

    final initialTrip = trips[_currentIndex];

    // Gunakan LayoutBuilder atau ConstrainedBox jika widget ini 
    // diletakkan di dalam Column lain yang tidak terbatas tingginya.
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ================= MAP =================
          SizedBox(
            height: 300, // Memberikan batas tinggi yang jelas
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(initialTrip.lat, initialTrip.long),
                zoom: 10,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: trips.map((trip) {
                return Marker(
                  markerId: MarkerId(trip.id),
                  position: LatLng(trip.lat, trip.long),
                  infoWindow: InfoWindow(title: trip.title),
                );
              }).toSet(),
            ),
          ),

          const SizedBox(height: 16),

          // ================= CAROUSEL =================
          SizedBox(
            height: 140,
            child: PageView.builder(
              controller: _pageController,
              itemCount: trips.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });

                final trip = trips[index];
                _mapController?.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(trip.lat, trip.long),
                  ),
                );
              },
              itemBuilder: (context, index) {
                final trip = trips[index];

                // GANTI 'YOUR_API_KEY' dengan key asli dari Google Cloud Console
                final imageUrl =
                    "https://maps.googleapis.com/maps/api/staticmap"
                    "?center=${trip.lat},${trip.long}"
                    "&zoom=13&size=300x300&maptype=roadmap"
                    "&key=AIzaSyDQ3ZyUuxaEOhe_s5J0vv7utyN4a5gM310";

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // ===== IMAGE DENGAN ERROR HANDLING (403) =====
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                          child: Image.network(
                            imageUrl,
                            width: 110,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            // Menangani Error 403 atau gambar gagal muat
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 110,
                                color: Colors.grey[300],
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.map_outlined, color: Colors.grey),
                                    Text("No Map", style: TextStyle(fontSize: 10, color: Colors.grey)),
                                  ],
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 110,
                                color: Colors.grey[100],
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        // ===== INFO (Gunakan Expanded untuk cegah overflow teks) =====
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  trip.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  trip.status,
                                  style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 12),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${trip.startDate.day}/${trip.startDate.month}/${trip.startDate.year}",
                                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
