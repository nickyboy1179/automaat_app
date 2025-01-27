import 'package:flutter/material.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'dart:convert';

class RentalCardItem extends StatelessWidget {
  final Rental rental;
  final Color color;
  final Color onColor;
  final void Function() onPressed;

  const RentalCardItem({
    super.key,
    required this.rental,
    required this.color,
    required this.onColor,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Date and Icon
              Row(
                children: [
                  Icon(Icons.calendar_today, color: color,),
                  SizedBox(width: 5),
                  Text(
                    '${rental.fromDate} | ${rental.toDate}',
                    style: TextStyle(
                      color: onColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        base64Decode(rental.car.picture),
                        height: 110,
                        width: 195,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${rental.car.brand} ${rental.car.model}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: onColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            rental.car.body,
                            style: TextStyle(
                              color: onColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.person, color: onColor),
                              SizedBox(width: 5),
                              Text(
                                '${rental.car.nrOfSeats} stoelen',
                                style: TextStyle(
                                  color: onColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "€ ${rental.car.price},00/dag",
                              style: TextStyle(
                                color: onColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

          // Car Details
        ),
      ),
    );
  }
}
