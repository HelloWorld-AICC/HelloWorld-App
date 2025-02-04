import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hello_world_mvp/route/domain/new_route_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../route/domain/route_service.dart';

class TokenAuthenticator {
  final Dio _dio;
  final String _baseUrl;
  final String _tokenRefreshUrl;
  final RouteService _routeService;

  TokenAuthenticator(
    this._dio,
    this._baseUrl,
    this._tokenRefreshUrl,
    this._routeService,
  );

  Future<RequestOptions> authenticate(
      RequestOptions requestOptions, Response response) async {
    final isPathRefresh =
        requestOptions.uri.toString() == '$_baseUrl$_tokenRefreshUrl';

    if (response.statusCode == 401 ||
        response.statusCode == 403 && !isPathRefresh) {
      final tokenRefreshSuccess = await _fetchUpdateToken();

      if (tokenRefreshSuccess) {
        final newToken = await fetchAccessToken();
        requestOptions.headers['Authorization'] = 'Bearer $newToken';
        return requestOptions;
      } else {
        _handleLogout();
        throw DioException(
          requestOptions: requestOptions,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
        );
      }
    }
    return requestOptions;
  }

  Future<bool> _fetchUpdateToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      final response = await _dio.post(
        '$_baseUrl$_tokenRefreshUrl',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['access_token'];
        await prefs.setString('accessToken', newToken);
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<String?> fetchAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  void _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    _routeService.router.go('/firstLaunch');
  }
}
