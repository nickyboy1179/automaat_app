import 'dart:convert';
import 'package:floor/floor.dart';

@entity
class Car {
  @primaryKey
  int id;
  String brand;
  String model;
  String picture;
  String pictureContentType;
  String fuel;
  String options;
  String licensePlate;
  int engineSize;
  int modelYear;
  String since;
  int price;
  int nrOfSeats;
  String body;
  double longitude;
  double latitude;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.picture,
    required this.pictureContentType,
    required this.fuel,
    required this.options,
    required this.licensePlate,
    required this.engineSize,
    required this.modelYear,
    required this.since,
    required this.price,
    required this.nrOfSeats,
    required this.body,
    required this.longitude,
    required this.latitude,
  });

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: (json["id"] is int ? json["id"] : (json["id"] as num).toInt()),
    brand: json["brand"],
    model: json["model"],
    picture: json["picture"],
    pictureContentType: json["pictureContentType"],
    fuel: json["fuel"],
    options: json["options"],
    licensePlate: json["licensePlate"],
    engineSize: (json["engineSize"] is int ? json["engineSize"] : (json["engineSize"] as num).toInt()),
    modelYear: (json["modelYear"] is int ? json["modelYear"] : (json["modelYear"] as num).toInt()),
    since: (json["since"]),
    price: (json["price"] is int ? json["price"] : (json["price"] as num).toInt()),
    nrOfSeats: (json["nrOfSeats"] is int ? json["nrOfSeats"] : (json["nrOfSeats"] as num).toInt()),
    body: json["body"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "model": model,
    "picture": picture,
    "pictureContentType": pictureContentType,
    "fuel": fuel,
    "options": options,
    "licensePlate": licensePlate,
    "engineSize": engineSize,
    "modelYear": modelYear,
    "since": since,
    "price": price,
    "nrOfSeats": nrOfSeats,
    "body": body,
    "longitude": longitude,
    "latitude": latitude,
  };


}
