// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      result: (json['result'] as List<dynamic>)
          .map((e) => AuthResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => AuthResult(
      types: json['types'] as String,
      token: json['token'] as String,
      tokenExpriresTime: DateTime.parse(json['tokenExpriresTime'] as String),
    );

Map<String, dynamic> _$AuthResultToJson(AuthResult instance) =>
    <String, dynamic>{
      'types': instance.types,
      'token': instance.token,
      'tokenExpriresTime': instance.tokenExpriresTime.toIso8601String(),
    };
