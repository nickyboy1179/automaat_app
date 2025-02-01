import 'package:automaat_app/controller/complete_rental_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:automaat_app/model/rest_model/rental_model.dart';

class CompleteRentalView extends StatefulWidget {
  final Rental rental;
  const CompleteRentalView({super.key, required this.rental});

  @override
  CompleteRentalViewState createState() => CompleteRentalViewState();
}

class CompleteRentalViewState extends State<CompleteRentalView> {
  late Rental rental;
  CompleteRentalController controller = CompleteRentalController();
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var position = await controller.getCurrentLocation(context);

    if (position == null) return;
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController.move(_selectedLocation!, 15.0);
  }

  void _onMapTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _selectedLocation = latlng;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLocation ?? LatLng(52.3676, 4.9041), // Default: Amsterdam
              initialZoom: 10.0,
              onTap: _onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLocation!,
                      width: 40.0,
                      height: 40.0,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton.extended(
              onPressed: _getCurrentLocation,
              label: Text("Use My Location"),
              icon: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
