import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://talented-loving-llama.ngrok-free.app/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/authenticate")
  Future<TokenResponse> authenticate(@Body() AuthRequest authRequest);
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
