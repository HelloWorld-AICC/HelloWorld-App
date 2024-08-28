import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_response.dart'; // Import the models

class AuthService {
  final Dio _dio;
  final String _loginUrl;

  AuthService(this._dio, this._loginUrl);

  Future<bool> login(String token) async {
    try {
      final response = await _dio.post(
        _loginUrl,
        data: {
          'token': token,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data);

      if (authResponse.isSuccess) {
        final authResult = authResponse.result.first;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', authResult.token);
        await prefs.setString('tokenExpriresTime',
            authResult.tokenExpriresTime.toIso8601String());

        return true;
      } else {
        log('Login failed: ${authResponse.message}');
        return false;
      }
    } catch (e) {
      log('Error occurred during login: $e');
      return false;
    }
  }

  Future<String?> fetchAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('tokenExpriresTime');
  }
}
