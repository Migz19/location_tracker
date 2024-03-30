class Location{
  double longitude,latitude;
  Location({required this.latitude, required this.longitude});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}