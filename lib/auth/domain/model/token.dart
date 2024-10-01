// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

enum TokenType {
  rtk,
  atk;

  factory TokenType.findByName(String name) {
    return TokenType.values.firstWhere(
        (element) => element.name.toUpperCase() == name.toUpperCase(),
        orElse: () {
      throw ("존재하지 않는 토큰 타입입니다.");
    });
  }
}

class Token extends Equatable {
  final TokenType type;
  final StringVO token;
  final DateVO tokenExpiresTime;
  const Token({
    required this.type,
    required this.token,
    required this.tokenExpiresTime,
  });

  @override
  List<Object?> get props => [type, token, tokenExpiresTime];
}
