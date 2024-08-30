import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Map<String, dynamic>> getGoogleAuthUrl() async {
    const url = 'http://15.164.219.143:8080/api/v1/google/login-view';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {'Accept': '*/*'},
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 301) {
        final parsedResponse = _parseLoginResponse(response);
        // log("[AuthService] Parsed Response: $parsedResponse");
        return parsedResponse;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Map<String, dynamic> _parseLoginResponse(Response response) {
    try {
      final responseData = response.data is String
          ? json.decode(response.data as String)
          : response.data as Map<String, dynamic>;

      // log("[AuthService] Response: $responseData");

      return {
        'isSuccess': responseData['isSuccess'] as bool,
        'googleAuthUrl': responseData['result'] as String,
      };
    } catch (e) {
      throw Exception('Failed to parse login response: $e');
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
