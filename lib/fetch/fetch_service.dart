import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'fetch_exception.dart';

class FetchService {
  Future<T?> fetchData<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.get(Uri.parse(url));

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          return fromJson(jsonResponse);
        case 400:
          throw FetchException(
              400, 'Bad Request: The server could not understand the request.');
        case 401:
          throw FetchException(401,
              'Unauthorized: Access is denied due to invalid credentials.');
        case 403:
          throw FetchException(403,
              'Forbidden: You do not have permission to access this resource.');
        case 404:
          throw FetchException(
              404, 'Not Found: The requested resource could not be found.');
        case 500:
          throw FetchException(
              500, 'Internal Server Error: An error occurred on the server.');
        case 503:
          throw FetchException(
              503, 'Service Unavailable: The server is currently unavailable.');
        default:
          throw FetchException(
              response.statusCode, 'Unexpected Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
      return null;
    }
  }
}
