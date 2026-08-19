import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mockai/core/network/api_endpoints.dart';
import 'package:mockai/core/network/auth_interceptor.dart';

class DioClient {
  static Dio createDio({required AuthInterceptor authInterceptor}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.reciveTimeout,
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    dio.interceptors.addAll([
      authInterceptor,
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
        ),
    ]);
    return dio;
  }
}
