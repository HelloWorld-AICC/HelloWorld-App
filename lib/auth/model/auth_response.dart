import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: 'isSuccess')
  final bool isSuccess;

  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'result')
  final List<AuthResult> result;

  AuthResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class AuthResult {
  @JsonKey(name: 'types')
  final String types;

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'tokenExpriresTime')
  final DateTime tokenExpriresTime;

  AuthResult({
    required this.types,
    required this.token,
    required this.tokenExpriresTime,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultToJson(this);
}
