// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hello_world_mvp/auth/domain/model/token.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class TokenDto {
  final String types;
  final String token;
  final String tokenExpiresTime;

  TokenDto({
    required this.types,
    required this.token,
    required this.tokenExpiresTime,
  });

  Token toDomain() {
    return Token(
        type: TokenType.findByName(types),
        token: StringVO(token),
        tokenExpiresTime: DateVO.fromString(tokenExpiresTime));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'types': types,
      'token': token,
      'tokenExpriresTime': tokenExpiresTime,
    };
  }

  factory TokenDto.fromJson(Map<String, dynamic> map) {
    return TokenDto(
      types: map['types'] as String,
      token: map['token'] as String,
      tokenExpiresTime: map['tokenExpriresTime'] as String,
    );
  }
}
