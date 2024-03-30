import 'location.dart';

class SnappedPoints{
  final Location location;
  final int? originalIndex;
  final String placeId;

  SnappedPoints({
    required this.location,
    this.originalIndex,
    required this.placeId,
  });
  factory SnappedPoints.fromJson(Map<String, dynamic> json) {
    return SnappedPoints(
      location: Location.fromJson(json['location']),
      originalIndex: json['originalIndex'],
      placeId: json['placeId'],
    );
  }
}
