import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:automaat_app/repository/retrofit/api_routes.dart';

import '../model/cars.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(ApiRoutes.authenticate)
  Future<TokenResponse> authenticate(@Body() AuthRequest authRequest);

  @GET(ApiRoutes.cars)
  Future<List<Cars>> getCars();
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
