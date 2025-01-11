import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<String> getToken() async {
    final perfs = await SharedPreferences.getInstance();
    return perfs.getString('token') ?? "Token not set";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Home')
    );
  }
}
