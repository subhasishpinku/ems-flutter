import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiClient {
  static final CookieJar cookieJar = CookieJar();

  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: "https://ems.ueplnet.com/api/",
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
            },
            validateStatus: (status) => status != null && status < 500,
          ),
        )
        ..interceptors.add(CookieManager(cookieJar))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              print("Request: ${options.method} ${options.path}");
              print("Data: ${options.data}");
              return handler.next(options);
            },
            onResponse: (response, handler) {
              print("Response: ${response.statusCode} ${response.data}");
              return handler.next(response);
            },
            onError: (DioException e, handler) {
              print("Error: ${e.message}");
              print("Error Response: ${e.response?.data}");
              return handler.next(e);
            },
          ),
        );
}
