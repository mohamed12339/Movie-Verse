

import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(defaultValue: "")
  final String name;
  @JsonKey(defaultValue: "")
  final String email;
  @JsonKey(defaultValue: "")
  final String password;
  @JsonKey(defaultValue: "")
  final String confirmPassword;
  @JsonKey(defaultValue: "")
  final String phone;

  @JsonKey(name: "avaterId")
  final int avaterId;

  RegisterRequest({
    this.name = "",
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.phone = "",
    this.avaterId = 0,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}