import 'package:automaat_app/model/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarList extends StatelessWidget {
  const CarList({super.key});

  // Future<String> getToken() async {
  //   final perfs = await SharedPreferences.getInstance();
  //   return perfs.getString('token') ?? "Token not set";
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            child: const Text("Fetch cars from backend"),
            onPressed:  () async {
              // try {
              //   final token = await getToken();
              //   final dio = Dio();
              //   dio.options.headers['Authorization'] = 'bearer $token';
              //   final apiService = ApiService(dio);
              //
              //   var carlist = await apiService.getCars();
              //   var car = carlist[0];
              //
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('$car')),
              //   );
              // } catch (e) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('Authentication failed: $e')),
              //   );
              // }
        },
      ),
    );
  }
}
