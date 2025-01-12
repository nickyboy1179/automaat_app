import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/authenticate")
  Future<TokenResponse> authenticate(@Body() AuthRequest authRequest);

  @GET("/cars/1")
  Future<List<Car>> getCars();
}

@JsonSerializable()
class Car {
  final int id;
  final String brand;
  final String model;
  final String picture;
  final String pictureContentType;
  final String fuel;
  final String options;
  final String licencePlate;
  final int engineSize;
  final String since;
  final int price;
  final int nrOfSeats;
  final String body;
  final int longitude;
  final int latitude;
  final int? inspections;
  final int? repairs;
  final int? rentals;

  const Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.picture,
    required this.pictureContentType,
    required this.fuel,
    required this.options,
    required this.licencePlate,
    required this.engineSize,
    required this.since,
    required this.price,
    required this.nrOfSeats,
    required this.body,
    required this.longitude,
    required this.latitude,
    required this.inspections,
    required this.repairs,
    required this.rentals,
  });

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}

@JsonSerializable()
class AuthRequest {
  final String username;
  final String password;
  final bool rememberMe;

  AuthRequest({
    required this.username,
    required this.password,
    required this.rememberMe,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}

@JsonSerializable()
class TokenResponse {
  final String id_token;

  TokenResponse({required this.id_token});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
