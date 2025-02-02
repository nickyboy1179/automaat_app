import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/controller/complete_rental_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
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
  final TextEditingController _mileageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    rental = widget.rental;
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

  Future<void> _completeRental(BuildContext context, Rental rental, LatLng latLng) async {
    if (_formKey.currentState!.validate()) {
      String mileage = _mileageController.text;

      bool response = await controller.sendConfirmation(
          rental,
          latLng,
          mileage
      );

      if (response) {
        _showError("Huurtermijn afgerond");
        if (!context.mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        _showError("Er ging iets mis, probeer het later nog eens");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    NetworkStateProvider networkStateProvider = Provider
        .of<NetworkStateProvider>(context);

    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildLocationCard(),
              SizedBox(height: 8,),
              ConfirmButton(
                  text: "locatie van telefoon gebruiken",
                  color: colorScheme.secondary,
                  onColor: colorScheme.onPrimary,
                  onPressed: () {
                    _getCurrentLocation();
                  }
              ),
              SizedBox(height: 16,),
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _mileageController,
                  decoration: InputDecoration(
                    hintText: "Voer kilometerstand in",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Voer de kilometerstand in";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16,),
              networkStateProvider.isConnected
              ? ConfirmButton(
                text: "Huurtermijn afronden",
                color: colorScheme.primary,
                onColor: colorScheme.onPrimary,
                onPressed: () {
                  _completeRental(context, rental, _selectedLocation!);
                }
              ) : ConfirmButton(
                  text: "Huurtermijn afronden",
                  color: colorScheme.tertiary,
                  onColor: colorScheme.onTertiary,
                  onPressed: () {}
              ),
            ],
          ),
        ),
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

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Locatie van de auto',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Druk op de kaart om een locatie aan te geven',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 0.4*MediaQuery.sizeOf(context).height,
            width: 400,
            child: _mapWidget(),
          ),
        ],
      ),
    );
  }

  Widget _mapWidget() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _selectedLocation ?? LatLng(52.3676, 4.9041),
        // Default: Amsterdam
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
    );
  }
}
