import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:automaat_app/view/rent_car_view.dart';
import 'package:automaat_app/common/static_elements.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/controller/car_controller.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/component/confirm_button.dart';

class CarView extends StatelessWidget {
  final Car car;
  final double _carInfoBoxWidth = 30.0;
  final CarController _controller = CarController();
  CarView({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    NetworkStateProvider networkStateProvider = Provider.of<NetworkStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Auto",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(StaticElements.borderRadius),
            ),
            elevation: StaticElements.elevation,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(StaticElements.borderRadius),
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
              borderRadius: BorderRadius.circular(StaticElements.borderRadius),
            ),
            elevation: StaticElements.elevation,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "${car.brand} ${car.model}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${car.modelYear}",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: _carInfoBoxWidth),
                      Text(
                        "${StaticElements.fuelTypes[car.fuel]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary
                        ),
                      ),
                      SizedBox(width: _carInfoBoxWidth),
                      Text(
                        "${StaticElements.bodyTypes[car.body]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${car.nrOfSeats} stoelen",
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.primary,
                          )),
                      SizedBox(width: _carInfoBoxWidth),
                      Text(
                          car.options,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.primary,
                          )
                      ),
                    ],

                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: _carInfoBoxWidth),
                      Text("€ ${car.price},00 per dag",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
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
            onPressed: () {_controller.onNavigate(context, car);}
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
