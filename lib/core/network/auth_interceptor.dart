import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mockai/core/network/api_endpoints.dart';
import 'package:mockai/core/storage/secure_storage_service.dart';

class AuthInterceptor extends QueuedInterceptor {
  final SecureStorageService _storageService;
  final Dio _refreshDio;

  Future<String?>? _refreshFuture;

  final _sessionExpiredController = StreamController<void>.broadcast();
  Stream<void> get onSessionExpired => _sessionExpiredController.stream;

  static const Set<String> _noAuthPaths = {
    ApiEndpoints.login,
    ApiEndpoints.refresh,
  };

  AuthInterceptor({required this._storageService, Dio? refreshDio})
    : _refreshDio =
          refreshDio ??
          Dio(
            BaseOptions(
              baseUrl: ApiEndpoints.baseUrl,
              connectTimeout: ApiEndpoints.connectTimeout,
              receiveTimeout: ApiEndpoints.reciveTimeout,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isNoAuthEndpoint = _noAuthPaths.any(
      (path) => options.path.contains(path),
    );
    if (isNoAuthEndpoint) {
      return handler.next(options);
    }

    final accessToken = await _storageService.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final requestOptions = err.requestOptions;

    // Only intercept 401 Unauthorized
    if (response?.statusCode != 401) {
      return handler.next(err);
    }

    // Prevent infinite loop if the refresh endpoint itself returns 401
    if (requestOptions.path.contains(ApiEndpoints.refresh) ||
        requestOptions.path.contains(ApiEndpoints.login)) {
      await _handleSessionExpired();
      return handler.next(err);
    }

    try {
      debugPrint(
        '[AuthInterceptor] 401 received for ${requestOptions.path}. Attempting token refresh...',
      );
      _refreshFuture ??= _performTokenRefresh();
      final newAccessToken = await _refreshFuture;

      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        debugPrint(
          '[AuthInterceptor] Token refresh succeeded. Retrying request: ${requestOptions.path}',
        );
        requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await _retry(requestOptions);
        return handler.resolve(retryResponse);
      } else {
        debugPrint(
          '[AuthInterceptor] Token refresh returned null. Expiring session.',
        );
        await _handleSessionExpired();
        return handler.reject(err);
      }
    } catch (e) {
      debugPrint('[AuthInterceptor] Token refresh retry failed with error: $e');
      await _handleSessionExpired();
      return handler.reject(err);
    }
  }

  Future<String?> _performTokenRefresh() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint(
          '[AuthInterceptor] No refresh token found in secure storage.',
        );
        return null;
      }

      debugPrint('[AuthInterceptor] Sending POST ${ApiEndpoints.refresh}');
      final response = await _refreshDio.post(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken, 'expiresInMins': 30},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : Map<String, dynamic>.from(response.data as Map);

        // Fallbacks for DummyJSON keys
        final newAccessToken =
            (data['accessToken'] ?? data['token']) as String?;
        final newRefreshToken =
            (data['refreshToken'] as String?) ?? refreshToken;

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await _storageService.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );
          debugPrint('[AuthInterceptor] New tokens saved successfully.');
          return newAccessToken;
        }
      }
      debugPrint(
        '[AuthInterceptor] Refresh response did not contain valid access token. Body: ${response.data}',
      );
      return null;
    } on DioException catch (e) {
      debugPrint(
        '[AuthInterceptor] DioException during token refresh: ${e.response?.statusCode} -> ${e.response?.data}',
      );
      return null;
    } catch (e) {
      debugPrint('[AuthInterceptor] Unexpected error during token refresh: $e');
      return null;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) {
    return _refreshDio.fetch<dynamic>(requestOptions);
  }

  Future<void> _handleSessionExpired() async {
    _refreshFuture = null;
    await _storageService.clear();
    _sessionExpiredController.add(null);
  }

  void dispose() {
    _sessionExpiredController.close();
  }
}
