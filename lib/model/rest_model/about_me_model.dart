import 'package:automaat_app/model/rest_model/system_user_model.dart';
import 'dart:convert';

class AboutMe {
  int id;
  int? nr;
  String lastName;
  String firstName;
  String? from;
  SystemUser systemUser;
  List<dynamic> rentals;
  dynamic location;

  AboutMe({
    required this.id,
    required this.nr,
    required this.lastName,
    required this.firstName,
    required this.from,
    required this.systemUser,
    required this.rentals,
    required this.location,
  });

  factory AboutMe.fromRawJson(String str) => AboutMe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutMe.fromJson(Map<String, dynamic> json) => AboutMe(
    id: json["id"],
    nr: json["nr"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    from: json["from"],
    systemUser: SystemUser.fromJson(json["systemUser"]),
    rentals: List<dynamic>.from(json["rentals"].map((x) => x)),
    location: json["location"],
  );

  bool get isEmpty => false;

  Map<String, dynamic> toJson() => {
    "id": id,
    "nr": nr,
    "lastName": lastName,
    "firstName": firstName,
    "from": from,
    "systemUser": systemUser.toJson(),
    "rentals": List<dynamic>.from(rentals.map((x) => x)),
    "location": location,
  };
}