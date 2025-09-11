import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  /// fromJson: يحول JSON -> Object
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  /// toJson: يحول Object -> JSON
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
