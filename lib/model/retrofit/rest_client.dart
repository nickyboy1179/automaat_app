import 'package:automaat_app/model/rest_model/am_register_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:automaat_app/model/retrofit/api_routes.dart';
import 'package:automaat_app/model/rest_model/about_me_model.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/model/rest_model/inspections_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(ApiRoutes.authenticate)
  Future<TokenResponse> authenticate(@Body() AuthRequest authRequest);

  @GET(ApiRoutes.cars)
  Future<List<Car>> getCars(
      @Query("page") int page,
      @Query("size") int size
      );

  @POST(ApiRoutes.rentals)
  Future<Rental> postRental(@Body() Rental rental);

  @PUT("${ApiRoutes.rentals}/{id}")
  Future<Rental> putRental(@Body() Rental rental, @Path('id') int id);

  @GET(ApiRoutes.aboutMe)
  Future<AboutMe> getUserInfo();

  @GET("${ApiRoutes.rentals}/{id}")
  Future<Rental> getRentalById(@Path('id') String id);

  @GET(ApiRoutes.rentals)
  Future<List<Rental>> getRentalsByCustomerId(
      @Query("customerId.equals") String id,
      @Query("page") String page,
      @Query("size") String size,
      );

  @GET(ApiRoutes.rentals)
  Future<List<Rental>> getRentalsByCarIdAndState(
      @Query("state.notIn") String stateNotIn,
      @Query("carId.equals") String carId,
      @Query("page") String page,
      @Query("size") String size,
      );

  @POST(ApiRoutes.inspection)
  Future<Inspection> postInspection(@Body() Inspection inspection);

  @POST(ApiRoutes.register)
  Future<void> postAccount(@Body() AmRegister account);

  @POST(ApiRoutes.forgotPassword)
  Future<void> postForgotPassword(@Body() String email);

  @GET(ApiRoutes.authenticate)
  Future<void> getAuth();
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
  final String token;

  TokenResponse({required this.token});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
