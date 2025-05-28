import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/service_location/repository/model/service_location_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetailsWidget extends StatelessWidget {
  const LocationDetailsWidget({super.key, required this.service});

  final ServiceLocation service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            service.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            service.category,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          if (service.hours != null) ...[
            const Text(
              'Working Hours:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(service.hours!),
            const SizedBox(height: 8),
          ],
          if (service.services != null) ...[
            const Text(
              'Services:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(service.services!),
            const SizedBox(height: 8),
          ],
          const Text(
            'Address:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(service.address),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => launchUrl(
                  Uri.parse('tel:${service.contact}'),
                ),
                icon: const Icon(Icons.phone),
                label: const Text('Call'),
              ),
              ElevatedButton.icon(
                onPressed: () => launchUrl(
                  Uri.parse(
                      'https://www.openstreetmap.org/directions?from=&to=${service.location.latitude},${service.location.longitude}'),
                ),
                icon: const Icon(Icons.directions),
                label: const Text('Directions'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
