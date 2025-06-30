// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:hubaix/features/bottom_navigation/pages/service_location/presentation/widgets/location_details_widget.dart';
// import 'package:hubaix/features/bottom_navigation/pages/service_location/repository/data/service_location_dummy_list.dart';
// import 'package:hubaix/utils/utils.dart';
// import 'package:latlong2/latlong.dart';
//
// class ServiceLocationPage extends StatefulWidget {
//   const ServiceLocationPage({super.key});
//
//   @override
//   _ServiceLocationPageState createState() => _ServiceLocationPageState();
// }
//
// class _ServiceLocationPageState extends State<ServiceLocationPage> {
//   String _selectedCategory = 'All';
//   final MapController _mapController = MapController();
//
//   final List<String> _categories = [
//     'All',
//     'Healthcare',
//     'NADRA',
//     'Grounds',
//     'Halls',
//     'Post Office',
//     'Education',
//     'Transport',
//     'Emergency',
//     'NGO'
//   ];
//
//   // Center of Lyari Town
//   final LatLng _lyariCenter = const LatLng(24.8736, 66.9928);
//
//   List<Marker> _getMarkers() {
//     return services
//         .where((service) =>
//             _selectedCategory == 'All' || service.category == _selectedCategory)
//         .map((service) => Marker(
//               point: service.location,
//               width: 40,
//               height: 40,
//               child: GestureDetector(
//                 onTap: () => Utils.showBottomSheet(
//                   context,
//                   LocationDetailsWidget(service: service),
//                 ),
//                 child: Icon(
//                   _getCategoryIcon(service.category),
//                   color: Theme.of(context).primaryColor,
//                   size: 40,
//                 ),
//               ),
//             ))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lyari Town Services'),
//       ),
//       body: Column(
//         children: [
//           // Category filter
//           Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: _categories.length,
//               itemBuilder: (context, index) {
//                 final category = _categories[index];
//                 final isSelected = category == _selectedCategory;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: FilterChip(
//                     selected: isSelected,
//                     label: Text(category),
//                     onSelected: (selected) {
//                       setState(() {
//                         _selectedCategory = category;
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Map
//           Expanded(
//             child: FlutterMap(
//               mapController: _mapController,
//               options: MapOptions(
//                 initialCenter: _lyariCenter,
//                 initialZoom: 14,
//                 maxZoom: 18,
//                 minZoom: 10,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   userAgentPackageName: 'com.example.app',
//                 ),
//                 MarkerLayer(
//                   markers: _getMarkers(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getCategoryIcon(String category) {
//     switch (category) {
//       case 'Healthcare':
//         return Icons.local_hospital_sharp;
//       case 'NADRA':
//         return Icons.card_membership;
//       case 'Post Office':
//         return Icons.local_post_office;
//       case 'Education':
//         return Icons.school;
//       case 'Transport':
//         return Icons.directions_bus;
//       case 'Emergency':
//         return Icons.emergency;
//       default:
//         return Icons.location_on;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hubaix/features/bottom_navigation/pages/service_location/presentation/widgets/location_details_widget.dart';
import 'package:hubaix/features/bottom_navigation/pages/service_location/repository/data/service_location_dummy_list.dart';
import 'package:hubaix/utils/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:hubaix/features/bottom_navigation/pages/service_location/repository/model/service_location_model.dart';

class ServiceLocationPage extends StatefulWidget {
  const ServiceLocationPage({super.key});

  @override
  _ServiceLocationPageState createState() => _ServiceLocationPageState();
}

class _ServiceLocationPageState extends State<ServiceLocationPage> {
  String _selectedCategory = 'All';
  final MapController _mapController = MapController();

  List<ServiceLocation> _services = [];
  bool _isLoading = true;
  String? _error;

  final List<String> _categories = [
    'All',
    'Healthcare',
    'NADRA',
    'Grounds',
    'Halls',
    'Post Office',
    'Education',
    'Transport',
    'Emergency',
    'NGO'
  ];

  // Center of Lyari Town
  final LatLng _lyariCenter = const LatLng(24.8736, 66.9928);

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final services = await fetchServiceLocations();
      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<Marker> _getMarkers() {
    return _services
        .where((service) =>
            _selectedCategory == 'All' || service.category == _selectedCategory)
        .map((service) => Marker(
              point: service.location,
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () => Utils.showBottomSheet(
                  context,
                  LocationDetailsWidget(service: service),
                ),
                child: Icon(
                  _getCategoryIcon(service.category),
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lyari Town Services')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lyari Town Services')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $_error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadServices,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lyari Town Services'),
      ),
      body: Column(
        children: [
          // Category filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Map
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _lyariCenter,
                initialZoom: 14,
                maxZoom: 18,
                minZoom: 10,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: _getMarkers(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Healthcare':
        return Icons.local_hospital_sharp;
      case 'NADRA':
        return Icons.card_membership;
      case 'Post Office':
        return Icons.local_post_office;
      case 'Education':
        return Icons.school;
      case 'Transport':
        return Icons.directions_bus;
      case 'Emergency':
        return Icons.emergency;
      default:
        return Icons.location_on;
    }
  }
}
