import 'package:automaat_app/model/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarList extends StatelessWidget {
  const CarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            child: const Text("Fetch cars from backend"),
            onPressed:  () async {
              final dio = Dio();
              final apiService = ApiService(dio);

              print(apiService.getCars());

        },
      ),
    );
  }
}
