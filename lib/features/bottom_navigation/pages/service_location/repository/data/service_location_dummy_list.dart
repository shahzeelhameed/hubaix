import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:hubaix/features/bottom_navigation/pages/service_location/repository/model/service_location_model.dart';

const String apiUrl = 'http://localhost:4000/api/location_services';

Future<List<ServiceLocation>> fetchServiceLocations() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((jsonItem) {
      return ServiceLocation(
        name: jsonItem['name'] ?? '',
        address: jsonItem['address'] ?? '',
        category: jsonItem['category'] ?? '',
        contact: jsonItem['contact'] ?? '',
        location: LatLng(
          (jsonItem['latitude'] as num).toDouble(),
          (jsonItem['longitude'] as num).toDouble(),
        ),
        hours: jsonItem['hours'] ?? '',
        services: jsonItem['services'] ?? '',
        website: jsonItem['website'],
      );
    }).toList();
  } else {
    throw Exception('Failed to load service locations');
  }
}
