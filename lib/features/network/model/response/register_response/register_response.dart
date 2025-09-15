import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String message;
  final RegisterData data;

  RegisterResponse({required this.message, required this.data});
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class RegisterData {
  final String email;
  final String password;
  final String name;
  final String phone;
  @JsonKey(name: 'avaterId')
  final int avaterId;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  RegisterData({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avaterId,
    @JsonKey(name: '_id') required this.id,
    required this.createdAt,
    required this.updatedAt,
    @JsonKey(name: '__v') required this.v,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);
}
