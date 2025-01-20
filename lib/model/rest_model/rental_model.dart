import 'dart:convert';

import 'car_model.dart';
import 'inspections_model.dart';
import 'customer_model.dart';

class Rental {
  int? id;
  String code;
  double longitude;
  double latitude;
  String fromDate;
  String toDate;
  String state;
  List<Inspection>? inspections;
  Customer customer;
  Car car;

  Rental({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.inspections,
    required this.customer,
    required this.car,
  });

  factory Rental.fromRawJson(String str) => Rental.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
    id: json["id"],
    code: json["code"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    state: json["state"],
    inspections: json["inspections"],
    customer: Customer.fromJson(json["customer"]),
    car: Car.fromJson(json["car"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "longitude": longitude,
    "latitude": latitude,
    "fromDate": fromDate,
    "toDate": toDate,
    "state": state,
    "inspections": inspections,
    "customer": customer.toJson(),
    "car": car.toJson(),
  };
}