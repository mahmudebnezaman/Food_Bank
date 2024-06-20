import 'package:latlong2/latlong.dart' as coordinates;

class SimpleLocationResult {
  final double latitude;
  final double longitude;

  SimpleLocationResult(this.latitude, this.longitude);

  coordinates.LatLng getLatLng() => coordinates.LatLng(latitude, longitude);

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  factory SimpleLocationResult.fromJson(Map<String, dynamic> json) {
    return SimpleLocationResult(
      json['latitude'],
      json['longitude'],
    );
  }
}
