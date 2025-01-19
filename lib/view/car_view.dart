import 'package:flutter/material.dart';
import 'car_list_view.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';

class CarView extends StatelessWidget {
  final Car car;
  const CarView({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Car view ${car.fuel}"),
    );
  }
}
