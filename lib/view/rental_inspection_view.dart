import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/viewmodel/car_list_viewmodel.dart';
import 'package:automaat_app/common/shared_widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../model/rest_model/rental_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                _buildReportButton(),
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
              Icon(Icons.calendar_today, color: Colors.purple),
              SizedBox(width: 8),
              Text(
                'Informatie',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
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
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCarInfoCard(BuildContext context) {
    return SharedWidgets.carCard(rental.car, context);
  }

  Widget _buildReportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          'Schade melden',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _OSMmap() {
    return OSMViewer(
      controller: SimpleMapController(
        initPosition: GeoPoint(
          latitude: rental.latitude,
          longitude: rental.longitude,
        ),
        markerHome: const MarkerIcon(
          icon: Icon(Icons.home),
        ),
      ),
      zoomOption: const ZoomOption(
        initZoom: 16,
        minZoomLevel: 11,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
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
      color: Colors.grey[700],
    );
  }
}
