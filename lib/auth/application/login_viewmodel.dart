// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';

@injectable
class LoginVM extends ChangeNotifier {
  final IAuthRepository repository;

  LoginVM({required this.repository});

  Future<void> signin() async {
    final successOrFailure = await repository.getAuthCodeFromGoogle();
  }
}
