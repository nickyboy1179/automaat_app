import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:automaat_app/model/retrofit/api_routes.dart';
import 'package:automaat_app/model/rest_model/about_me_model.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(ApiRoutes.authenticate)
  Future<TokenResponse> authenticate(@Body() AuthRequest authRequest);

  @GET("${ApiRoutes.cars}?size=30")
  Future<List<Car>> getCars();

  @POST(ApiRoutes.rentals)
  Future<void> postRental(@Body() Rental rental);

  @GET(ApiRoutes.aboutMe)
  Future<AboutMe> getUserInfo();

  @GET("${ApiRoutes.rentals}/{id}")
  Future<Rental> getRentalById(@Path('id') String id);

  @GET(ApiRoutes.rentals)
  Future<List<Rental>> getRentalsByCustomerId(@Query("customerId.equals") String id,
      @Query("page") String page,
      @Query("size") String size,
      );

  @GET(ApiRoutes.rentals)
  Future<List<Rental>> getRentalsByCarIdAndState(@Query("state.notIn") String stateNotIn,
      @Query("carId.equals") String carId,
      @Query("page") String page,
      @Query("size") String size,
      );
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
