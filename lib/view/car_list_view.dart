import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/controller/car_list_viewmodel.dart';
import 'package:automaat_app/common/shared_widgets.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final carListViewmodel = CarListViewmodel();

  String searchQuery = "";

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
                  borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
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
                  List<Car> cars = snapshot.data!;
                  // Apply search and filter
                  cars = cars.where((car) {
                    final matchesSearch = "${car.brand} ${car.model}"
                        .toLowerCase()
                        .contains(searchQuery);
                    return matchesSearch;
                  }).toList();

                  if (cars.isEmpty) {
                    return const Center(child: Text('No cars match the criteria.'));
                  }

                  return ListView.builder(
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final Car car = cars[index];
                      return SharedWidgets.carCard(car, context);
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