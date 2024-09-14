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
            "https://www.gotoend.store",
            // "https://www.gotoend.store/mvc/api/v1/google/code",
            scopes: ['openid', 'profile', 'email'],
            serviceConfiguration: const AuthorizationServiceConfiguration(
                authorizationEndpoint:
                    "https://accounts.google.com/o/oauth2/v2/auth",
                tokenEndpoint:
                    "https://www.gotoend.store/mvc/v1/google/login")));
  }

  // final _myRepo = MovieRepoImp();

  // ApiResponse<MoviesMain> movieMain = ApiResponse.loading();

  // void _setMovieMain(ApiResponse<MoviesMain> response) {
  //   print("MARAJ :: $response");
  //   movieMain = response;
  //   notifyListeners();
  // }

  // Future<void> fetchMovies() async {
  //   _setMovieMain(ApiResponse.loading());
  //   _myRepo
  //       .getMoviesList()
  //       .then((value) => _setMovieMain(ApiResponse.completed(value)))
  //       .onError((error, stackTrace) =>
  //           _setMovieMain(ApiResponse.error(error.toString())));
  // }
}
