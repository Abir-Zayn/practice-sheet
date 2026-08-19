import 'package:mockai/features/auth/data/datasource/auth_api_service.dart';
import 'package:mockai/features/auth/data/models/auth_response_model.dart';
import 'package:mockai/features/auth/data/models/login_request_model.dart';
import 'package:mockai/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<UserModel> getMe();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;
  const AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) {
    return _apiService.login(request);
  }

  @override
  Future<UserModel> getMe() async {
    final response = await _apiService.getMe();
    return UserModel(
      id: response.id ?? 0,
      username: response.username ?? "",
      email: response.email ?? "",
      firstName: response.firstName ?? "",
      lastName: response.lastName ?? "",
      imageUrl: response.image,
    );
  }
}
