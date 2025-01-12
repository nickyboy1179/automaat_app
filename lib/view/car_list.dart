import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:automaat_app/viewmodel/car_list_viewmodel.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final carListViewmodel = CarListViewmodel();
  final double borderRadius = 16.0;
  final double columnItemPadding = 4;
  final double fontSizeTitle = 18;
  final double fontSizeAttr = 10;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: carListViewmodel.fetchCarList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No cars available'));
        } else {
          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  elevation: 4,
                  child: Row(
                    children: [
                      // Car Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image.memory(
                          base64Decode(car.picture),
                          height: 130,
                          width: 230,
                          fit: BoxFit.cover,
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
                                color: Color(0xFF8E48C1),
                              ),
                            ),
                            SizedBox(height: columnItemPadding),
                            Text(
                              car.fuel,
                              style: TextStyle(fontSize: fontSizeAttr, color: Color(0xFF8E48C1)),
                            ),
                            SizedBox(height: columnItemPadding),
                            Text(
                              car.body,
                              style: TextStyle(fontSize: fontSizeAttr, color: Color(0xFF8E48C1)),
                            ),
                            SizedBox(height: columnItemPadding),
                            Text(
                              car.licensePlate,
                              style: TextStyle(fontSize: fontSizeAttr, color: Color(0xFF8E48C1)),
                            ),
                            SizedBox(height: columnItemPadding),
                            Text(
                              "${car.nrOfSeats} stoelen",
                              style: TextStyle(fontSize: fontSizeAttr, color: Color(0xFF8E48C1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    );
  }
}
