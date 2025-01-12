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
  final double columnItemPadding = 2;
  final double outerCardPadding = 4.0;
  final double fontSizeTitle = 18;
  final double fontSizeAttr = 12;

  String searchQuery = "";
  String selectedFuel = "All";

  // List of filters (you can expand this as needed)
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Zoeken',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Car List
          Expanded(
            child: FutureBuilder(
              future: carListViewmodel.fetchCarList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No cars available'));
                } else {
                  var cars = snapshot.data!;
                  // Apply search and filter
                  cars = cars.where((car) {
                    final matchesSearch = "${car.brand} ${car.model}"
                        .toLowerCase()
                        .contains(searchQuery);
                    final matchesFuel = selectedFuel == "All" || car.fuel == selectedFuel;
                    return matchesSearch && matchesFuel;
                  }).toList();

                  if (cars.isEmpty) {
                    return const Center(child: Text('No cars match the criteria.'));
                  }

                  return ListView.builder(
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final car = cars[index];
                      return Padding(
                        padding: EdgeInsets.all(outerCardPadding),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          elevation: 4,
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
                                        color: const Color(0xFF8E48C1),
                                      ),
                                    ),
                                    SizedBox(height: columnItemPadding),
                                    Text(
                                      fuelTypes[car.fuel]!,
                                      style: TextStyle(fontSize: fontSizeAttr, color: const Color(0xFF8E48C1)),
                                    ),
                                    SizedBox(height: columnItemPadding),
                                    Text(
                                      bodyTypes[car.body]!,
                                      style: TextStyle(fontSize: fontSizeAttr, color: const Color(0xFF8E48C1)),
                                    ),
                                    SizedBox(height: columnItemPadding),
                                    Text(
                                      "Nummerbord: ${car.licensePlate}",
                                      style: TextStyle(fontSize: fontSizeAttr, color: const Color(0xFF8E48C1)),
                                    ),
                                    SizedBox(height: columnItemPadding),
                                    Text(
                                      "${car.nrOfSeats} stoelen",
                                      style: TextStyle(fontSize: fontSizeAttr, color: const Color(0xFF8E48C1)),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
