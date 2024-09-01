import 'user.dart';

class UserPreferences {
  // Private constructor
  UserPreferences._privateConstructor();

  // Static variable to hold the single instance
  static final UserPreferences _instance =
      UserPreferences._privateConstructor();

  // Factory constructor to return the single instance
  factory UserPreferences() {
    return _instance;
  }

  // User data
  User myUser = const User(
    imagePath:
        'https://sseksak.s3.ap-northeast-2.amazonaws.com/user/1c9f5485-6fbf-4d51-aed6-914065dc33bf',
    name: 'abc',
    id: '1',
  );
}
