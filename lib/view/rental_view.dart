import 'package:automaat_app/view/rental_inspection_view.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/service/locator.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/controller/rental_controller.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/component/rental_card_item.dart';

class RentalView extends StatefulWidget {
  const RentalView({super.key});

  @override
  State<RentalView> createState() => _RentalViewState();
}

class _RentalViewState extends State<RentalView> {
  final controller = RentalController();
  final restClient = locator<RestClient>();

  void navigateToRentalInspectionView(BuildContext context, Rental rental) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RentalInspectionView(
          rental: rental,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getUserRentals(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return RefreshIndicator(
              onRefresh: () async {
                controller.getUserRentals(context);
                setState(() {});
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
                    const Center(
                        child:
                            Text('Reserverings informatie niet beschikbaar')),
                  ],
                ),
              ));
        } else {
          List<Rental> rentals = snapshot.data!;
          List<Rental> activeRentals = [
            for (Rental e in rentals)
              if (e.state == "ACTIVE" || e.state == "RESERVED") e
          ];
          List<Rental> oldRentals = [
            for (Rental e in rentals)
              if (e.state != "ACTIVE" && e.state != "RESERVED") e
          ];

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Actieve reserveringen",
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.getUserRentals(context);
                      setState(() {});
                    },
                    child: ListView.builder(
                        itemCount: activeRentals.length + oldRentals.length + 1,
                        itemBuilder: (context, index) {
                          if (index < activeRentals.length) {
                            return RentalCardItem(
                                rental: activeRentals[index],
                                color: Theme.of(context).colorScheme.surface,
                                onColor:
                                    Theme.of(context).colorScheme.onSurface,
                                onPressed: (() {
                                  navigateToRentalInspectionView(
                                      context, activeRentals[index]);
                                }));
                          } else if (index == activeRentals.length) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                Center(
                                  child: Text(
                                    "Oude reserveringen",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          } else {
                            Rental rental =
                                oldRentals[index - activeRentals.length - 1];
                            return RentalCardItem(
                                rental: rental,
                                color: Theme.of(context).colorScheme.surface,
                                onColor:
                                    Theme.of(context).colorScheme.onSurface,
                                onPressed: (() {
                                  navigateToRentalInspectionView(
                                      context, rental);
                                }));
                          }
                        }),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
