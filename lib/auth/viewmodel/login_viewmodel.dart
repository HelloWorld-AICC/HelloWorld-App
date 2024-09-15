import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class LoginVM extends ChangeNotifier {
  FlutterAppAuth _appAuth = const FlutterAppAuth();

  AuthorizationTokenResponse? response;

  Future<void> authorize() async {
    final AuthorizationTokenResponse response =
        await _appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
            "283350122061-so9tmsluv514ctr9ccm50jrtdlmsht7k.apps.googleusercontent.com",
            // "gotoend:/home",
            // "com.example.hello_world_mvp:/oauthredirect",
            "https://www.gotoend.store/mvc/api/v1/google/code",
            scopes: ['openid', 'profile', 'email'],
            serviceConfiguration: const AuthorizationServiceConfiguration(
                authorizationEndpoint:
                    "https://accounts.google.com/o/oauth2/v2/auth",
                tokenEndpoint:
                    "https://www.gotoend.store/mvc/v1/google/login")));
  }
}
