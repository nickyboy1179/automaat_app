import 'dart:convert';

class AmRegister {
  int? id;
  String login;
  String firstName;
  String lastName;
  String email;
  String imageUrl;
  bool activated;
  String langKey;
  String? createdBy;
  DateTime createdDate;
  String? lastModifiedBy;
  DateTime lastModifiedDate;
  List<String> authorities;
  String password;

  AmRegister({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.activated,
    required this.langKey,
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
    required this.authorities,
    required this.password,
  });

  factory AmRegister.fromRawJson(String str) => AmRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AmRegister.fromJson(Map<String, dynamic> json) => AmRegister(
    id: json["id"],
    login: json["login"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    imageUrl: json["imageUrl"],
    activated: json["activated"],
    langKey: json["langKey"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    authorities: List<String>.from(json["authorities"].map((x) => x)),
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "login": login,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "imageUrl": imageUrl,
    "activated": activated,
    "langKey": langKey,
    "createdBy": createdBy,
    "createdDate": "${createdDate.toIso8601String()}Z",
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": "${lastModifiedDate.toIso8601String()}Z",
    "authorities": List<dynamic>.from(authorities.map((x) => x)),
    "password": password,
  };
}