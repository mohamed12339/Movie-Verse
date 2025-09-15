import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String message;
  final TokenData data;

  TokenResponse({required this.message, required this.data});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class TokenData {
  final String email;
  final String password;
  final String name;
  final String phone;

  @JsonKey(name: "avaterId")
  final int avaterId;

  @JsonKey(name: "_id")
  final String id;

  final String createdAt;
  final String updatedAt;

  @JsonKey(name: "__v")
  final int v;

  TokenData({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avaterId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDataToJson(this);
}
