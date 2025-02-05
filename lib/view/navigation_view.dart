import 'package:automaat_app/view/profile_view.dart';
import 'package:automaat_app/view/rental_view.dart';
import 'package:flutter/material.dart';
import 'car_list_view.dart';
import 'notifications_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> with TickerProviderStateMixin<NavigationView> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, Icons.car_crash,      'Auto huren',),
    Destination(1, Icons.notifications,  'Meldingen',),
    Destination(2, Icons.car_rental,     'Reservering',),
    Destination(3, Icons.account_circle, 'Profiel',),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((AnimationStatus status) {
      if (status.isDismissed) {
        setState(() {}); // Rebuild unselected destinations offstage.
      }
    });
  }

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
        (int index) => GlobalKey(),
    ).toList();

    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
          (int index) => buildFaderController(),
    ).toList();
    destinationFaders[selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationViews = allDestinations.map<Widget>(
        (Destination destination) {
          return FadeTransition(
            opacity: destinationFaders[destination.index].drive(tween),
            child: DestinationView(
              destination: destination,
              navigatorKey: navigatorKeys[destination.index],
            ),
          );
        },
    ).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPopWithResult: (result) {
        final NavigatorState navigator =
            navigatorKeys[selectedIndex].currentState!;
        navigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          toolbarHeight: 0,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: allDestinations.map(
              (Destination destination) {
                final int index = destination.index;
                final Widget view = destinationViews[index];
                if (index == selectedIndex) {
                  destinationFaders[index].forward();
                  return Offstage(offstage: false, child: view,);
                } else {
                  destinationFaders[index].reverse();
                  if (destinationFaders[index].isAnimating) {
                    return IgnorePointer(child: view,);
                  }
                  return Offstage(child: view,);
                }
              },
          ).toList(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: allDestinations.map<NavigationDestination>(
              (Destination destination) {
                return NavigationDestination(
                    icon: Icon(destination.icon),
                    label: destination.title,
                );
              }
          ).toList(),
        ),
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.icon, this.title);
  final int index;
  final IconData icon;
  final String title;
}

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            switch (widget.destination.index) {
              case 0:
                return CarList();
              case 1:
                return NotificationsView();
              case 2:
                return RentalView();
              case 3:
                return ProfileView();
            }
            assert(false);
            return const SizedBox();
          },
        );
      },
    );
  }
}