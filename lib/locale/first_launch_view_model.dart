import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirstLaunchViewModel extends ChangeNotifier {
  Future<String?> fetchLocaleFromServer(String userId) async {
    final response = await http.get(
      Uri.parse('http://13.209.87.5:8082/user/'),
      headers: <String, String>{
        'accept': '*/*',
        'user_id': userId,
      },
    );

    if (response.statusCode == 200) {
      // Assume the response body contains the locale string
      return response.body;
    } else {
      // Handle error
      return null;
    }
  }
}
