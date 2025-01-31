import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:automaat_app/view/rent_car_view.dart';
import 'package:automaat_app/common/static_elements.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/controller/car_viewmodel.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/component/confirm_button.dart';

class CarView extends StatelessWidget {
  final Car car;
  final double _carInfoBoxWidth = 30.0;
  final CarViewmodel _carViewmodel = CarViewmodel();
  CarView({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    NetworkStateProvider networkStateProvider = Provider.of<NetworkStateProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
            ),
            elevation: SharedWidgets.elevation,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
                child: Image.memory(
                  base64Decode(car.picture),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
            ),
            elevation: SharedWidgets.elevation,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "${car.brand} ${car.model}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: SharedWidgets.accentColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${SharedWidgets.fuelTypes[car.fuel]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: SharedWidgets.accentColor,
                        ),
                      ),
                      SizedBox(width: _carInfoBoxWidth),
                      Text(
                        "${SharedWidgets.bodyTypes[car.body]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: SharedWidgets.accentColor,
                        ),
                      ),
                      SizedBox(width: _carInfoBoxWidth),
                      Text(
                        "${car.modelYear}",
                        style: TextStyle(
                          fontSize: 14,
                          color: SharedWidgets.accentColor,
                        ),
                      ),
                      SizedBox(width: _carInfoBoxWidth),
                      Text(car.options,
                          style: TextStyle(
                            fontSize: 16,
                            color: SharedWidgets.accentColor,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${car.nrOfSeats} stoelen",
                          style: TextStyle(
                            fontSize: 16,
                            color: SharedWidgets.accentColor,
                          )),
                      SizedBox(width: _carInfoBoxWidth),
                      Text("€ ${car.price},00 per dag",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: _carInfoBoxWidth),
                      Text("${car.engineSize} Motor formaat",
                          style: TextStyle(
                            fontSize: 16,
                            color: SharedWidgets.accentColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          networkStateProvider.isConnected
              ? ConfirmButton(
            text: "Huren",
            color: colorScheme.primary,
            onColor: colorScheme.onPrimary,
            onPressed: () {_carViewmodel.onNavigate(context, car);}
          )
              : ConfirmButton(
            text: "Huren",
            color: colorScheme.tertiary,
            onColor: colorScheme.onTertiary,
            onPressed: () {},
          ),

        ],
      ),
        ),
    );
  }
}
