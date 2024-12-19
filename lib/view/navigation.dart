import 'package:flutter/material.dart';
import 'package:automaat_app/view/settings.dart';
import 'package:automaat_app/view/explore.dart';
import 'package:automaat_app/view/home.dart';

class Navigation extends StatefulWidget {
  const Navigation ({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Navigation'),
          backgroundColor: Colors.purple,
          ),

        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        body: [
          Home(),
          Explore(),
          Settings(),
        ][currentPageIndex],
      );
  }
}