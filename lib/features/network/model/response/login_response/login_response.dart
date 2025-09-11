import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;

  /// السيرفر بيرجع التوكين كسلسلة داخل "data"
  @JsonKey(fromJson: _asString, toJson: _toJson)
  final String data;

  LoginResponse({required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  static String _asString(dynamic v) => v?.toString() ?? '';
  static dynamic _toJson(String v) => v;
}
