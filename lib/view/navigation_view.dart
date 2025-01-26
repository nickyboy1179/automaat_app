import 'package:automaat_app/view/rental_view.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/view/profile_view.dart';
import 'package:automaat_app/view/notifications_view.dart';
import 'package:automaat_app/view/car_list_view.dart';

class Navigation extends StatefulWidget {
  const Navigation ({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  final GlobalKey<NavigatorState> carListNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> rentalNavigatorKey = GlobalKey<NavigatorState>();

  void _onNavigationTap(int index) {
    switch (index) {
      case 0:
        carListNavigatorKey.currentState?.popUntil((route) => route.isFirst);
      case 2:
        rentalNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    }

    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Scaffold(
            bottomNavigationBar: NavigationBar(
              selectedIndex: currentPageIndex,
              onDestinationSelected: _onNavigationTap,
              destinations: const <Widget>[
                NavigationDestination(
                  icon: Icon(Icons.car_crash),
                  label: 'Auto huren',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications,),
                  label: 'Meldingen',
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
            body: Stack(
              children: [
                Offstage(
                  offstage: currentPageIndex != 0,
                  child: PopScope(
                    canPop: true,
                    child: Navigator(
                      key: carListNavigatorKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => CarList(),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: currentPageIndex != 1,
                  child: NotificationsView(),
                ),
                Offstage(
                  offstage: currentPageIndex != 2,
                  child: PopScope(
                    canPop: false,
                    child: Navigator(
                      key: rentalNavigatorKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => RentalView(),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: currentPageIndex != 3,
                  child: ProfileView(),
                ),
              ],
            ),
          ),
        ),
    );
  }
}