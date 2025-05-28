import 'package:latlong2/latlong.dart';

class ServiceLocation {
  final String name;
  final String address;
  final String category;
  final String contact;
  final LatLng location;
  final String? hours;
  final String? services;
  final String? email;
  final String? website;

  ServiceLocation({
    required this.name,
    required this.address,
    required this.category,
    required this.contact,
    required this.location,
    this.website,
    this.email,
    this.hours,
    this.services,
  });
}
