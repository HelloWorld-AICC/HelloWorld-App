// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:hello_world_mvp/auth/domain/model/token.dart';

class TokenSet extends Equatable {
  final List<Token> tokens;
  const TokenSet({
    required this.tokens,
  });

  @override
  List<Object?> get props => [tokens];

  Token? get atk {
    if (tokens.any((e) => e.type == TokenType.atk)) {
      return tokens.singleWhere((e) => e.type == TokenType.atk);
    }
    return null;
  }

  Token? get rtk {
    if (tokens.any((e) => e.type == TokenType.rtk)) {
      return tokens.singleWhere((e) => e.type == TokenType.rtk);
    }
    return null;
  }
}
