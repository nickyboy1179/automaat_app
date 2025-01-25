import 'package:automaat_app/view/rental_inspection_view.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../model/rest_model/car_model.dart';
import '../model/rest_model/rental_model.dart';
import '../view/car_view.dart';

class SharedWidgets {
  static final double borderRadius = 16.0;
  static final double columnItemPadding = 2;
  static final double outerCardPadding = 4.0;
  static final double fontSizeTitle = 18;
  static final double fontSizeAttr = 12;
  static final double elevation = 4;

  //Colors
  static final Color accentColor = const Color(0xFF8E48C1);
  static final Color backgroundColor = const Color(0xFFf3edf7);

  static ButtonStyle automaatButtonStyle = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(Color(0xFFf3edf7)),
    fixedSize: const WidgetStatePropertyAll<Size>(Size(400,50)),
    shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16))
    ),
    elevation: const WidgetStatePropertyAll<double>(4.0),
  );

  static ButtonStyle automaatConfirmButtonStyle = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(Color(0xFF8E48C1)),
    fixedSize: const WidgetStatePropertyAll<Size>(Size(400,50)),
    shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16))
    ),
    elevation: const WidgetStatePropertyAll<double>(4.0),
  );

  static ButtonStyle automaatConfirmButtonStyleNoConnection = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(Color(0xFF9A9797)),
    fixedSize: const WidgetStatePropertyAll<Size>(Size(400,50)),
    shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16))
    ),
    elevation: const WidgetStatePropertyAll<double>(4.0),
  );

  static final Map<String, String> fuelTypes = {
    "GASOLINE": "Benzine",
    "DIESEL": "Diesel",
    "HYBRID": "Hybride",
    "ELECTRIC": "Elektrisch",
  };

  static final Map<String, String> bodyTypes = {
    "SUV": "Suv",
    "SEDAN": "Sedan",
    "HATCHBACK": "Hatchback",
    "TRUCK": "Truck",
    "STATIONWAGON": "Stationwagen",
  };

  static Widget carCard(Car car, BuildContext context) => Padding(
    padding: EdgeInsets.all(outerCardPadding),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => CarView(car: car,),
          //   ),
          // );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: Theme.of(context).colorScheme.surface,
          elevation: elevation,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.memory(
                    base64Decode(car.picture),
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
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: columnItemPadding),
                    Text(
                      fuelTypes[car.fuel]!,
                      style: TextStyle(fontSize: fontSizeAttr, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(height: columnItemPadding),
                    Text(
                      bodyTypes[car.body]!,
                      style: TextStyle(fontSize: fontSizeAttr, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(height: columnItemPadding),
                    Text(
                      "${car.nrOfSeats} stoelen",
                      style: TextStyle(fontSize: fontSizeAttr, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  static Widget rentalCard(Rental rental, BuildContext context) =>
      GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RentalInspectionView(rental: rental,),
          //   ),
          // );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Date and Icon
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: accentColor),
                    SizedBox(width: 5),
                    Text(
                      '${rental.fromDate} | ${rental.toDate}',
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image.memory(
                          base64Decode(rental.car.picture),
                          height: 110,
                          width: 195,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${rental.car.brand} ${rental.car.model}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              rental.car.body,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.person, color: accentColor),
                                SizedBox(width: 5),
                                Text(
                                  '${rental.car.nrOfSeats} stoelen',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "€ ${rental.car.price},00/dag",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),

            // Car Details
          ),
        ),
      );
}
