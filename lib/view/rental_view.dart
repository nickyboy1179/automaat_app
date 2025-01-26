// import 'package:automaat_app/common/static_elements.dart';
// import 'package:flutter/material.dart';
// import 'package:automaat_app/locator.dart';
// import 'package:automaat_app/model/retrofit/rest_client.dart';
// import 'package:automaat_app/controller/rental_viewmodel.dart';
// import 'package:automaat_app/model/rest_model/rental_model.dart';
//
// class RentalView extends StatelessWidget {
//   final rentalViewmodel = RentalViewmodel();
//   final restClient = locator<RestClient>();
//
//   RentalView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: rentalViewmodel.getUserRentals(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No rental information available'));
//         } else {
//           List<Rental> rentals = snapshot.data!;
//           List<Rental> activeRentals = [
//             for (Rental e in rentals)
//               if (e.state == "ACTIVE" || e.state == "RESERVED") e
//           ];
//           List<Rental> oldRentals = [
//             for (Rental e in rentals)
//               if (e.state != "ACTIVE" && e.state != "RESERVED") e
//           ];
//
//           return Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Actieve reserveringen",
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: SharedWidgets.accentColor,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: activeRentals.length + oldRentals.length + 1,
//                     itemBuilder: (context, index) {
//                       if (index < activeRentals.length) {
//                         return SharedWidgets.rentalCard(
//                           activeRentals[index],
//                           context,
//                         );
//                       } else if (index == activeRentals.length) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 16),
//                             Text(
//                               "Oude reserveringen",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 color: SharedWidgets.accentColor,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                           ],
//                         );
//                       } else {
//                         return SharedWidgets.rentalCard(
//                           oldRentals[index - activeRentals.length - 1],
//                           context,
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }
