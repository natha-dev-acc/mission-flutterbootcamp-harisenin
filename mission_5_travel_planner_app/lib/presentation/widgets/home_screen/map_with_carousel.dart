import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart'; // Untuk marker angka

// Import sudah disesuaikan dengan struktur provider Anda
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
  Set<Marker> _markers = {}; // State untuk menampung label markers

  @override
  void initState() {
    super.initState();
    // Memastikan marker dibuat setelah frame pertama dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMarkers();
    });
  }

  // Fungsi untuk membuat marker angka menggunakan package label_marker
  void _updateMarkers() async {
    final trips = ref.read(tripProvider).trips;
    if (trips.isEmpty) return;

    Set<Marker> tempMarkers = {};

    for (int i = 0; i < trips.length; i++) {
      final trip = trips[i];
      tempMarkers.addLabelMarker(
        LabelMarker(
          label: "${i + 1}",
          markerId: MarkerId(trip.id),
          position: LatLng(trip.lat, trip.long),
          backgroundColor: Colors.green,
          textStyle: const TextStyle(
            fontSize: 45,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    // Cukup panggil await tanpa variabel 'updatedMarkers' untuk menghilangkan warning
    await Future.wait(
      tempMarkers.map((m) => Future.value(m)),
    );

    if (mounted) {
      setState(() {
        _markers = tempMarkers;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch tripProvider untuk mendapatkan data terbaru
    final tripState = ref.watch(tripProvider);
    final trips = tripState.trips;

    if (trips.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text("Belum ada data trip")),
      );
    }

    // Koordinat untuk garis Polyline hijau
    final List<LatLng> polylinePoints =
        trips.map((t) => LatLng(t.lat, t.long)).toList();

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ================= MAP =================
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(trips[0].lat, trips[0].long),
                zoom: 7,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                _updateMarkers(); // Update marker saat map siap
              },
              markers: _markers,
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route_line"),
                  points: polylinePoints,
                  color: Colors.green,
                  width: 4,
                  geodesic: true,
                ),
              },
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
                  _currentIndex = index; // Sekarang variabel ini terpakai
                });

                final trip = trips[index];
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(trip.lat, trip.long),
                    10, // Zoom otomatis saat geser kartu
                  ),
                );
              },
              itemBuilder: (context, index) {
                final trip = trips[index];
                // Highlight jika kartu sedang aktif
                final bool isActive = _currentIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Card(
                    elevation: isActive ? 6 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: isActive 
                        ? const BorderSide(color: Colors.green, width: 2)
                        : BorderSide.none,
                    ),
                    child: Row(
                      children: [
                        // ===== PENGGANTI STATIC MAP (ANGKA URUTAN) =====
                        Container(
                          width: 110,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.green : Colors.grey[400],
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on, 
                                  color: isActive ? Colors.white : Colors.white70, 
                                  size: 20
                                ),
                                Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "TRIP ${index + 1}",
                                  style: const TextStyle(color: Colors.white70, fontSize: 9),
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // ===== INFO TRIP =====
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
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
                                  trip.status.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month, size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${trip.startDate.day}/${trip.startDate.month}/${trip.startDate.year}",
                                      style: const TextStyle(fontSize: 12, color: Colors.black54),
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
