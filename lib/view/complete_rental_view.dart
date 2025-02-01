import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class CompleteRentalView extends StatelessWidget {
  final Rental rental;
  const CompleteRentalView({super.key, required this.rental});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

        ],
      ),
    );
  }

  // Widget _buildLocationCard() {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: _cardDecoration(),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Locatie',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: Theme.of(context).colorScheme.primary,
  //           ),
  //         ),
  //         SizedBox(height: 16),
  //         SizedBox(
  //           height: 200,
  //           width: 400,
  //           child: osm(rental.latitude, rental.longitude),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // BoxDecoration _cardDecoration() {
  //   return BoxDecoration(
  //     color: Theme.of(context).colorScheme.surface,
  //     borderRadius: BorderRadius.circular(12),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.grey,
  //         blurRadius: 6,
  //         spreadRadius: 2,
  //         offset: Offset(0, 3),
  //       ),
  //     ],
  //   );
  // }

  Widget osm(double latitude, double longitude) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
        initialZoom: 11,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              width: 200,
              height: 200,
              child: Icon(
                Icons.car_rental,
                color: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
