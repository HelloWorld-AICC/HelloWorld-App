import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../model/user_preferences.dart';

class PreferenceService {
  static Future<void> updateUserPreferences() async {
    try {
      // GET 요청을 보냅니다.
      final response = await http.get(
        Uri.parse('http://15.165.84.103:8080/myPage/'),
        headers: {
          'accept': '*/*',
          'user_id': '1',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['isSuccess'] == true && data['code'] == "COMMON200") {
          final result = data['result'];

          UserPreferences().myUser = User(
            imagePath: result['userImg'],
            name: result['name'],
            id: result['userId'].toString(),
          );
          log("[PreferenceService] myUser updated: ${UserPreferences().myUser.id}, ${UserPreferences().myUser.name}, ${UserPreferences().myUser.imagePath}");
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Failed to send request');
      }
    } catch (e) {
      print('Error: $e');
      // 에러 처리 로직을 여기에 추가할 수 있습니다.
    }
  }
}
