import 'dart:convert';

class Customer {
  int id;
  int nr;
  String lastName;
  String firstName;
  String from;

  Customer({
    required this.id,
    required this.nr,
    required this.lastName,
    required this.firstName,
    required this.from,
  });

  factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    nr: json["nr"],
    lastName: json["lastName"],
    firstName: json["firstName"],
    from: json["from"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nr": nr,
    "lastName": lastName,
    "firstName": firstName,
    "from": from,
  };
}