// import 'dart:convert';
// import 'package:automaat_app/view/rent_car_view.dart';
// import 'package:flutter/material.dart';
// import 'package:automaat_app/model/rest_model/car_model.dart';
// import 'package:automaat_app/common/static_elements.dart';
//
// import '../controller/car_viewmodel.dart';
//
// class CarView extends StatelessWidget {
//   final Car car;
//   final double _carInfoBoxWidth = 30.0;
//   final CarViewmodel _carViewmodel = CarViewmodel();
//   CarView({super.key, required this.car});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
//             ),
//             elevation: SharedWidgets.elevation,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
//                 child: Image.memory(
//                   base64Decode(car.picture),
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
//             ),
//             elevation: SharedWidgets.elevation,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Text(
//                     "${car.brand} ${car.model}",
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: SharedWidgets.accentColor,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "${SharedWidgets.fuelTypes[car.fuel]}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: SharedWidgets.accentColor,
//                         ),
//                       ),
//                       SizedBox(width: _carInfoBoxWidth),
//                       Text(
//                         "${SharedWidgets.bodyTypes[car.body]}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: SharedWidgets.accentColor,
//                         ),
//                       ),
//                       SizedBox(width: _carInfoBoxWidth),
//                       Text(
//                         "${car.modelYear}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: SharedWidgets.accentColor,
//                         ),
//                       ),
//                       SizedBox(width: _carInfoBoxWidth),
//                       Text(car.options,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: SharedWidgets.accentColor,
//                           )),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("${car.nrOfSeats} stoelen",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: SharedWidgets.accentColor,
//                           )),
//                       SizedBox(width: _carInfoBoxWidth),
//                       Text("€ ${car.price},00 per dag",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.black,
//                           )),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(width: _carInfoBoxWidth),
//                       Text("${car.engineSize} Motor formaat",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: SharedWidgets.accentColor,
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           FutureBuilder<bool>(
//             future: _carViewmodel.checkCarAvailable(car),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return ElevatedButton(
//                   style: SharedWidgets.automaatConfirmButtonStyleNoConnection,
//                   onPressed: () => {
//
//                   },
//                   child: Text(
//                     "Auto niet beschikbaar",
//                     style: TextStyle(
//                       fontSize: 22,
//                       color: Colors.white54,
//                     ),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(child: Text("Error: ${snapshot.error}"));
//               } else {
//                 if (snapshot.data == true) {
//                   return ElevatedButton(
//                     style: SharedWidgets.automaatConfirmButtonStyle,
//                     onPressed: () => {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => RentCarView(
//                           car: car,
//                         )
//                         ),
//                       ),
//                     },
//                     child: Text(
//                       "Huren",
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: Colors.white,
//                       ),
//                     ),
//                   );
//                 } else {
//                   return ElevatedButton(
//                     style: SharedWidgets.automaatConfirmButtonStyleNoConnection,
//                     onPressed: () => {
//
//                     },
//                     child: Text(
//                       "Auto niet beschikbaar",
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: Colors.white54,
//                       ),
//                     ),
//                   );
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
