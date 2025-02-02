import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:automaat_app/model/rest_model/car_model.dart';

class CarListItem extends StatefulWidget {
  final Car car;
  final Color color;
  final Color onColor;
  final void Function() onPressed;

  const CarListItem({
    Key? key,
    required this.car,
    required this.color,
    required this.onColor,
    required this.onPressed,
  }): super(key: key);

  @override
  CarListItemSate createState() => CarListItemSate();
}

class CarListItemSate extends State<CarListItem> {
  late Car car;
  late Color color;
  late Color onColor;
  late void Function() onPressed;
  late var _imageBytes;

  final double borderRadius = 16.0;
  final double columnItemPadding = 2;
  final double outerCardPadding = 4.0;
  final double fontSizeTitle = 18;
  final double fontSizeAttr = 12;
  final double elevation = 4;

  final Map<String, String> fuelTypes = {
    "GASOLINE": "Benzine",
    "DIESEL": "Diesel",
    "HYBRID": "Hybride",
    "ELECTRIC": "Elektrisch",
  };

  final Map<String, String> bodyTypes = {
    "SUV": "Suv",
    "SEDAN": "Sedan",
    "HATCHBACK": "Hatchback",
    "TRUCK": "Truck",
    "STATIONWAGON": "Stationwagen",
  };

  @override
  void initState() {
    super.initState();
    car = widget.car;
    color = widget.color;
    onColor = widget.onColor;
    onPressed = widget.onPressed;
    _imageBytes = base64Decode(widget.car.picture); // Decode once
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(outerCardPadding),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: color,
          elevation: elevation,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.memory(
                    _imageBytes,
                    height: 110,
                    width: 195,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${car.brand} ${car.model}",
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                        color: onColor,
                      ),
                    ),
                    SizedBox(height: columnItemPadding),
                    Text(
                      fuelTypes[car.fuel]!,
                      style: TextStyle(
                          fontSize: fontSizeAttr,
                          color: onColor
                      ),
                    ),
                    SizedBox(height: columnItemPadding),
                    Text(
                      bodyTypes[car.body]!,
                      style: TextStyle(
                          fontSize: fontSizeAttr,
                          color: onColor
                      ),
                    ),
                    SizedBox(height: columnItemPadding),
                    Text(
                      "${car.nrOfSeats} stoelen",
                      style: TextStyle(
                          fontSize: fontSizeAttr,
                          color: onColor
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
