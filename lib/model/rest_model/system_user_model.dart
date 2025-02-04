import 'dart:convert';

class SystemUser {
  String createdBy;
  dynamic createdDate;
  String lastModifiedBy;
  dynamic lastModifiedDate;
  int id;
  String login;
  String firstName;
  String lastName;
  String email;
  bool activated;
  String langKey;
  String? imageUrl;
  dynamic resetDate;

  SystemUser({
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.activated,
    required this.langKey,
    required this.imageUrl,
    required this.resetDate,
  });

  factory SystemUser.fromRawJson(String str) => SystemUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SystemUser.fromJson(Map<String, dynamic> json) => SystemUser(
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: json["lastModifiedDate"],
    id: json["id"],
    login: json["login"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    activated: json["activated"],
    langKey: json["langKey"],
    imageUrl: json["imageUrl"],
    resetDate: json["resetDate"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate,
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate,
    "id": id,
    "login": login,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "activated": activated,
    "langKey": langKey,
    "imageUrl": imageUrl,
    "resetDate": resetDate,
  };
}