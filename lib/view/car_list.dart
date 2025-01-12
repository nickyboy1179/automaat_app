import 'package:flutter/material.dart';
import 'package:automaat_app/viewmodel/car_list_viewmodel.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final carListViewmodel = CarListViewmodel();

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
                return ListTile(
                  title: Text(car.brand),
                  subtitle: Text('Model: ${car.model}'),
                );
              },
            );
          }
        }
    );
  }
}
