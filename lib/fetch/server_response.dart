// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServerResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final Map<String, dynamic> result;

  ServerResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'code': code,
      'message': message,
      'result': result,
    };
  }

  factory ServerResponse.fromJson(Map<String, dynamic> map) {
    return ServerResponse(
        isSuccess: map['isSuccess'] as bool,
        code: map['code'] as String,
        message: map['message'] as String,
        result: Map<String, dynamic>.from(
          (map['result'] as Map<String, dynamic>),
        ));
  }
}
