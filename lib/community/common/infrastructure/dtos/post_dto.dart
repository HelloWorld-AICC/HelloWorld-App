import 'dart:io';

import 'package:hello_world_mvp/community/common/domain/post.dart';

class PostDto {
  final String title;
  final String body;
  final List<File> medias;

  PostDto({
    required this.title,
    required this.body,
    required this.medias,
  });

  Post toDomain() {
    return Post(title: title, body: body, medias: medias);
  }

  factory PostDto.fromDomain(Post post) {
    return PostDto(
      title: post.title,
      body: post.body,
      medias: post.medias,
    );
  }

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      title: json['title'],
      body: json['body'],
      medias: json['medias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'medias': medias,
    };
  }
}
