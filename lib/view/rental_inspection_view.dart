import 'package:automaat_app/component/car_list_item.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/view/complete_rental_view.dart';
import 'package:automaat_app/view/report_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:automaat_app/model/rest_model/rental_model.dart';

class RentalInspectionView extends StatefulWidget {
  final Rental rental;
  const RentalInspectionView({super.key, required this.rental});

  @override
  RentalInspectionViewState createState() => RentalInspectionViewState();
}

class RentalInspectionViewState extends State<RentalInspectionView> {
  late Rental rental;

  @override
  void initState() {
    super.initState();
    rental = widget.rental;
  }

  void _navigateToReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportView(rental: rental,),
      ),
    );
  }

  void _navigateToRentalCompletion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompleteRentalView(rental: rental,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoCard(),
                SizedBox(height: 16),
                _buildLocationCard(),
                SizedBox(height: 16),
                _buildCarInfoCard(context),
                SizedBox(height: 16),
                ConfirmButton(
                    text: "Schade melden",
                    color: colorScheme.primary,
                    onColor: colorScheme.onPrimary,
                    onPressed: () {
                      _navigateToReport(context);
                    },
                ),
                SizedBox(height: 16),
                ConfirmButton(
                    text: "Einde huurtermijn",
                    color: colorScheme.primary,
                    onColor: colorScheme.onPrimary,
                    onPressed: () {
                      _navigateToRentalCompletion(context);
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: 8),
              Text(
                'Informatie',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Startdatum: ${rental.fromDate}', style: _infoTextStyle()),
          SizedBox(height: 8),
          Text('Inleverdatum: ${rental.toDate}', style: _infoTextStyle()),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Locatie',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 200,
            width: 400,
            child: osm(rental.latitude, rental.longitude),
          ),
        ],
      ),
    );
  }

  Widget _buildCarInfoCard(BuildContext context) {
    return CarListItem(
        car: rental.car,
        color: Theme.of(context).colorScheme.surface,
        onColor: Theme.of(context).colorScheme.onSurface,
        onPressed: (() {}),
    );
  }

  Widget osm(double latitude, double longitude) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
        initialZoom: 11,
        interactionOptions: InteractionOptions(
          cursorKeyboardRotationOptions: CursorKeyboardRotationOptions.disabled(),
          flags: InteractiveFlag.drag | InteractiveFlag.rotate,
        ),

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

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 6,
          spreadRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  TextStyle _infoTextStyle() {
    return TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
