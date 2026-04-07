class TripEntity {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;
  final double lat;
  final double long;

  TripEntity({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.lat,
    required this.long,
  });
}