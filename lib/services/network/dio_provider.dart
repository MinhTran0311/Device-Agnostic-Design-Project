import 'package:dio/dio.dart';

class DioProvider {
  Dio? dio;

  Dio getInstance() {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = "https://dad-quiz-api.deno.dev";
      dio!.options.connectTimeout = const Duration(seconds: 60);
      dio!.options.contentType = 'application/json';
    }
    return dio!;
  }
}
