import 'dart:convert';

class Inspection {
  int? id;
  String? code;
  int? odometer;
  String? result;
  String? description;
  String? photo;
  String? photoContentType;
  DateTime? completed;

  Inspection({
    required this.id,
    required this.code,
    required this.odometer,
    required this.result,
    required this.description,
    required this.photo,
    required this.photoContentType,
    required this.completed,
  });

  factory Inspection.fromRawJson(String str) => Inspection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
    id: json["id"],
    code: json["code"],
    odometer: json["odometer"],
    result: json["result"],
    description: json["description"],
    photo: json["photo"],
    photoContentType: json["photoContentType"],
    completed: DateTime.parse(json["completed"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "odometer": odometer,
    "result": result,
    "description": description,
    "photo": photo,
    "photoContentType": photoContentType,
    "completed": "${completed?.toIso8601String()}Z",
  };
}