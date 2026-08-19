import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor{
  final Dio dio;
  final int maxRetries;
  final List<Duration> retryDelays;

  RetryInterceptor({
    required this.dio,
    this.maxRetries=3,
    this.retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ]
  });

  @override  
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final extra = err.requestOptions.extra;
    final int retryCount = extra['retry_count'] ?? 0;

    // 1. Get Request
    final bool isGetRequest = err.requestOptions.method.toUpperCase() == 'GET';

    // 2. Connection/TimeOut 
    final bool isNetworkError = 
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout;

    // 3. Retry Condition
    if (retryCount < maxRetries && isGetRequest && isNetworkError) {
      final delay = retryCount < retryDelays.length ? retryDelays[retryCount] : retryDelays.last;

      extra['retry_count'] = retryCount + 1;

      await Future.delayed(delay);

      try {
        // send request again
        final response = await dio.fetch(err.requestOptions);

        // re-try 
        return handler.resolve(response); 
      } on DioException catch (e) {
        return super.onError(e, handler);
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }
}
  