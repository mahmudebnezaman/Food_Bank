import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, double>?> getCoordinatesFromSearch(String searchTerm) async {
  final url =
      'https://nominatim.openstreetmap.org/search?q=$searchTerm&format=json&limit=1';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body) as List;
    if (data.isNotEmpty) {
      final location = data[0];
      return {
        'latitude': double.parse(location['lat']),
        'longitude': double.parse(location['lon']),
      };
    }
  }
  return null;
}

Future<List<String>> getAutocompleteSuggestions(String input) async {
  final url = 'https://photon.komoot.io/api/?q=$input';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map;
    final features = data['features'] as List;
    return features
        .map((feature) =>
            '${feature['properties']['name'] ?? ''} ${feature['properties']['city'] ?? ''} ${feature['properties']['country'] ?? ''}')
        .toList();
  } else {
    throw Exception('Failed to load suggestions');
  }
}
