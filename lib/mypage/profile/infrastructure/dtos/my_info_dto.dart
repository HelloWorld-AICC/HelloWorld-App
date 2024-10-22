import 'dart:convert';

import 'package:hello_world_mvp/mypage/profile/domain/model/my_info.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyInfoDto {
  final String name;
  final String userImg;

  MyInfoDto({
    required this.name,
    required this.userImg,
  });

  MyInfo toDomain() {
    return MyInfo(name: name, userImg: userImg);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'userImg': userImg,
    };
  }

  factory MyInfoDto.fromJson(Map<String, dynamic> map) {
    return MyInfoDto(
      name: map['name'] as String,
      userImg: map['userImg'] as String,
    );
  }
}
