import 'package:dio/dio.dart';
import 'package:mockai/core/network/api_endpoints.dart';
import 'package:mockai/features/auth/data/models/auth_response_model.dart';
import 'package:mockai/features/auth/data/models/login_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiEndpoints.login)
  Future<AuthResponseModel> login(@Body() LoginRequestModel body);

  @POST(ApiEndpoints.refresh)
  Future<AuthResponseModel> refreshToken(@Body() Map<String, dynamic> body);

  @GET(ApiEndpoints.me)
  Future<AuthResponseModel> getMe();
}
