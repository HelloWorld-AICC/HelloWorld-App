class PureUserModel {
  final String id;
  final String username;
  final String email;

  PureUserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory PureUserModel.fromJson(Map<String, dynamic> json) {
    return PureUserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
