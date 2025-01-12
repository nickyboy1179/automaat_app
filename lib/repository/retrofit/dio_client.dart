import 'package:automaat_app/repository/retrofit/token_interceptor.dart';
import 'package:dio/dio.dart';


Dio buildDioClient(String base) {
  final dio = Dio()..options = BaseOptions(baseUrl: base);

  dio.interceptors.addAll(
      [
        TokenInterceptor(),
      ]
  );

  return dio;
}