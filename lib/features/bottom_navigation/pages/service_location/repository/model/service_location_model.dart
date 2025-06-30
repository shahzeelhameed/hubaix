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

final List<ServiceLocation> dummyServiceLocations = [
  ServiceLocation(
    name: 'Happy Paws Vet Clinic',
    address: '123 Pet Street, Lahore',
    category: 'Veterinary',
    contact: '+92 300 1234567',
    location: const LatLng(31.5204, 74.3587),
    hours: '9:00 AM - 7:00 PM',
    services: 'Checkups, Vaccinations, Surgery',
    email: 'contact@happypaws.com',
    website: 'https://happypaws.com',
  ),
  ServiceLocation(
    name: 'Tail Waggers Grooming',
    address: '456 Fur Ave, Karachi',
    category: 'Grooming',
    contact: '+92 312 7654321',
    location: const LatLng(24.8607, 67.0011),
    hours: '10:00 AM - 6:00 PM',
    services: 'Bathing, Trimming, Styling',
    email: 'info@tailwaggers.pk',
    website: 'https://tailwaggers.pk',
  ),
  ServiceLocation(
    name: 'Pet Paradise Store',
    address: '789 Whiskers Blvd, Islamabad',
    category: 'Pet Store',
    contact: '+92 333 9876543',
    location: const LatLng(33.6844, 73.0479),
    services: 'Food, Accessories, Toys',
    website: 'https://petparadise.com.pk',
  ),
  ServiceLocation(
    name: 'Purrfect Boarding House',
    address: '22 Meow Lane, Rawalpindi',
    category: 'Boarding',
    contact: '+92 301 6543210',
    location: const LatLng(33.5651, 73.0169),
    hours: 'Open 24/7',
    email: 'bookings@purrfect.pk',
  ),
];
