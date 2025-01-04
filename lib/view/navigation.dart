import 'package:flutter/material.dart';
import 'package:automaat_app/view/settings.dart';
import 'package:automaat_app/view/car_list.dart';
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
              icon: Icon(Icons.car_crash),
              label: 'Auto lijst',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications,),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.car_rental),
              label: 'Reservering',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: 'Profiel',
            ),
          ],
        ),
        body: [
          Home(),
          CarList(),
          Settings(),
          Home(),
          Home(),
        ][currentPageIndex],
      );
  }
}