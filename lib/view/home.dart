import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Automaat'),
          backgroundColor: Colors.purple,
          ),
        
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'List'
              ),
            ])
        ,
        ),
      );
  }
}