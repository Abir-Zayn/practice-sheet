import 'package:json_annotation/json_annotation.dart';
import 'package:mockai/features/auth/domain/entities/user.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String accessToken;
  final String refreshToken;

  const AuthResponseModel({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  User? toEntity() {
    if (id == null || username == null) return null;
    return User(
      id: id!,
      username: username!,
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      imageUrl: image,
    );
  }
}
